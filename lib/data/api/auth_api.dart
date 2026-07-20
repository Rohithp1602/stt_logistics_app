import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../models/driver_model.dart';
import '../local/hive_boxes.dart';
import '../../core/errors/failures.dart';
import '../../core/security/password_hasher.dart';
import '../../core/enums/verification_status.dart';

/// Abstract interface for authentication API operations.
abstract class AuthApi {
  /// Registers a new user with email, password, and optional driver details.
  Future<UserModel> register({
    required String email,
    required String password,
    String? displayName,
    String? phone,
    String? cdlNumber,
    String? hub,
    String? photoPath,
  });

  /// Authenticates user with email and password.
  Future<UserModel> login({
    required String email,
    required String password,
  });

  /// Logs out the current user and clears session.
  Future<void> logout();

  /// Restores user session if available.
  Future<UserModel?> restoreSession();

  /// Gets the currently logged-in user.
  Future<UserModel?> getCurrentUser();

  /// Updates the profile of the currently logged-in user.
  Future<UserModel> updateProfile({
    String? displayName,
    String? phone,
    String? cdlNumber,
    String? hub,
    String? photoPath,
  });
}

/// Hive-based implementation of authentication API.
class HiveAuthApi implements AuthApi {
  static const String _sessionKeyLoggedIn = 'is_logged_in';
  static const String _sessionKeyUserEmail = 'user_email';

  final _uuid = const Uuid();

  Box<Map> get _usersBox => Hive.box(HiveBoxes.users);
  Box<Map> get _driversBox => Hive.box(HiveBoxes.drivers);
  Box get _sessionBox => Hive.box(HiveBoxes.session);

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? displayName,
    String? phone,
    String? cdlNumber,
    String? hub,
    String? photoPath,
  }) async {
    // Normalize email
    final normalizedEmail = email.trim().toLowerCase();
    
    // Add delay as specified in requirements
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Check if email already exists
    final existingUserMap = _usersBox.get(normalizedEmail);
    if (existingUserMap != null) {
      throw const AuthFailure('Email already exists');
    }
    
    // Generate user ID and hash password
    final userId = _uuid.v4();
    final passwordHash = PasswordHasher.hash(password);
    final now = DateTime.now();
    
    // Create user model
    final user = UserModel(
      id: userId,
      email: normalizedEmail,
      passwordHash: passwordHash.hash,
      passwordSalt: passwordHash.salt,
      displayName: displayName,
      phone: phone ?? '',
      photoPath: photoPath,
      createdAt: now,
    );
    
    // Store user in Hive
    await _usersBox.put(normalizedEmail, user.toMap());
    
    // Always create driver profile with verified status
    final driver = DriverModel(
      userId: userId,
      name: displayName ?? '',
      phone: phone ?? '',
      cdlNumber: cdlNumber ?? '',
      hub: hub ?? '',
      status: VerificationStatus.verified,
      photoPath: photoPath,
    );
    
    await _driversBox.put(userId, driver.toMap());
    
    // Set session
    await _setSession(user);
    
    // Return user without password fields for security
    return user.copyWith(passwordHash: '', passwordSalt: '');
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Normalize email
    final normalizedEmail = email.trim().toLowerCase();
    
    // Add delay as specified in requirements
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Get user from Hive
    final userMap = _usersBox.get(normalizedEmail);
    if (userMap == null) {
      throw const AuthFailure('Invalid email or password');
    }
    
    final userMapCasted = Map<String, dynamic>.from(userMap);
    final user = UserModel.fromMap(userMapCasted);
    
    // Verify password
    final isValid = PasswordHasher.verify(
      password,
      user.passwordSalt,
      user.passwordHash,
    );
    
    if (!isValid) {
      throw const AuthFailure('Invalid email or password');
    }
    
    // Set session
    await _setSession(user);
    
    // Return user without password fields for security
    return user.copyWith(passwordHash: '', passwordSalt: '');
  }

  @override
  Future<void> logout() async {
    await _clearSession();
  }

  @override
  Future<UserModel?> restoreSession() async {
    final sessionMap = _sessionBox.toMap();
    final isLoggedIn = sessionMap[_sessionKeyLoggedIn] as bool?;
    final userEmail = sessionMap[_sessionKeyUserEmail] as String?;
    
    if (isLoggedIn != true || userEmail == null) {
      return null;
    }
    
    // Get user from Hive
    final userMap = _usersBox.get(userEmail);
    if (userMap == null) {
      // Session exists but user was deleted, clear session
      await _clearSession();
      return null;
    }
    
    final userMapCasted = Map<String, dynamic>.from(userMap);
    final user = UserModel.fromMap(userMapCasted);
    
    // Return user without password fields for security
    return user.copyWith(passwordHash: '', passwordSalt: '');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return await restoreSession();
  }

  /// Sets the user session in Hive.
  Future<void> _setSession(UserModel user) async {
    await _sessionBox.put(_sessionKeyLoggedIn, true);
    await _sessionBox.put(_sessionKeyUserEmail, user.email);
  }

  /// Clears the user session from Hive.
  Future<void> _clearSession() async {
    await _sessionBox.delete(_sessionKeyLoggedIn);
    await _sessionBox.delete(_sessionKeyUserEmail);
  }

  @override
  Future<UserModel> updateProfile({
    String? displayName,
    String? phone,
    String? cdlNumber,
    String? hub,
    String? photoPath,
  }) async {
    // Get current user session
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw const AuthFailure('No user logged in');
    }

    // Get the full user record (with password fields) from storage
    final userMap = _usersBox.get(currentUser.email);
    if (userMap == null) {
      throw const AuthFailure('User not found in storage');
    }

    final userMapCasted = Map<String, dynamic>.from(userMap);
    final fullUser = UserModel.fromMap(userMapCasted);

    // Update user fields
    final updatedUser = fullUser.copyWith(
      displayName: displayName ?? fullUser.displayName,
      phone: phone ?? fullUser.phone,
      photoPath: photoPath ?? fullUser.photoPath,
    );

    // Save updated user to Hive
    await _usersBox.put(currentUser.email, updatedUser.toMap());

    // Sync driver profile when any driver-relevant field is provided
    if (displayName != null ||
        phone != null ||
        cdlNumber != null ||
        hub != null ||
        photoPath != null) {
      final driverMap = _driversBox.get(fullUser.id);
      if (driverMap != null) {
        final driverMapCasted = Map<String, dynamic>.from(driverMap);
        final driver = DriverModel.fromMap(driverMapCasted);
        
        final updatedDriver = driver.copyWith(
          name: displayName ?? driver.name,
          phone: phone ?? driver.phone,
          cdlNumber: cdlNumber ?? driver.cdlNumber,
          hub: hub ?? driver.hub,
          photoPath: photoPath ?? driver.photoPath,
        );
        
        await _driversBox.put(fullUser.id, updatedDriver.toMap());
      }
    }

    // Return user without password fields for security
    return updatedUser.copyWith(passwordHash: '', passwordSalt: '');
  }
}