import '../../core/errors/failures.dart';
import '../../services/auth_service.dart';
import '../models/user_model.dart';
import '../api/auth_api.dart';

/// Auth use-cases exposed to controllers.
///
/// Keeps login/logout orchestration out of the UI layer.
class AuthRepository {
  AuthRepository({
    required this._api,
    required this._authService,
  });

  final AuthApi _api;
  final AuthService _authService;

  /// Registers a new user and opens a session on success.
  ///
  /// Throws [AuthFailure] when registration fails (e.g., email already exists).
  Future<UserModel> register({
    required String email,
    required String password,
    String? displayName,
    String? phone,
    String? cdlNumber,
    String? hub,
    String? photoPath,
  }) async {
    final user = await _api.register(
      email: email,
      password: password,
      displayName: displayName,
      phone: phone,
      cdlNumber: cdlNumber,
      hub: hub,
      photoPath: photoPath,
    );
    await _authService.setSession(user);
    return user;
  }

  /// Authenticates with [email] / [password] and opens a session on success.
  ///
  /// Throws [AuthFailure] when credentials are rejected.
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final user = await _api.login(email: email, password: password);
    await _authService.setSession(user);
    return user;
  }

  /// Ends the current session and clears persisted auth flags.
  Future<void> logout() async {
    await _api.logout();
    await _authService.clearSession();
  }

  /// Updates the current user's profile and syncs with auth service.
  ///
  /// Throws [AuthFailure] when no user is logged in or update fails.
  Future<UserModel> updateProfile({
    String? displayName,
    String? phone,
    String? cdlNumber,
    String? hub,
    String? photoPath,
  }) async {
    final updatedUser = await _api.updateProfile(
      displayName: displayName,
      phone: phone,
      cdlNumber: cdlNumber,
      hub: hub,
      photoPath: photoPath,
    );
    await _authService.setSession(updatedUser);
    return updatedUser;
  }
}
