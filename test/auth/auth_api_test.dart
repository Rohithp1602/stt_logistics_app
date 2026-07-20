import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:stt_logistics_app/data/api/auth_api.dart';
import 'package:stt_logistics_app/data/models/user_model.dart';
import 'package:stt_logistics_app/core/errors/failures.dart';

void main() {
  group('AuthApi Tests', () {
    late HiveAuthApi authApi;
    late Directory tempDir;

    setUp(() async {
      // Create temp directory for Hive storage
      tempDir = Directory.systemTemp.createTempSync();
      Hive.init(tempDir.path);
      
      // Initialize Hive boxes
      await Hive.openBox<Map>('users');
      await Hive.openBox<Map>('drivers');
      await Hive.openBox('session');
      
      authApi = HiveAuthApi();
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    group('User Registration', () {
      test('should register new user successfully', () async {
        final user = await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'Test User',
        );

        expect(user.email, 'test@example.com');
        expect(user.displayName, 'Test User');
        expect(user.id, isNotNull);
        expect(user.passwordHash, ''); // Password hash should be cleared for security
      });

      test('should normalize email during registration', () async {
        final user = await authApi.register(
          email: '  TEST@EXAMPLE.COM  ',
          password: 'password123',
          displayName: 'Test User',
        );

        expect(user.email, 'test@example.com');
      });

      test('should throw AuthFailure when email already exists', () async {
        // Register first user
        await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'First User',
        );

        // Try to register with same email
        expect(
          () => authApi.register(
            email: 'test@example.com',
            password: 'different123',
            displayName: 'Second User',
          ),
          throwsA(isA<AuthFailure>()),
        );
      });

      test('should register driver with CDL number', () async {
        final user = await authApi.register(
          email: 'driver@example.com',
          password: 'password123',
          displayName: 'Driver User',
          cdlNumber: 'CDL123456',
          hub: 'Test Hub',
        );

        expect(user.email, 'driver@example.com');
        expect(user.displayName, 'Driver User');
        // Note: CDL number is stored in separate driver profile, not UserModel
      });
    });

    group('User Login', () {
      setUp(() async {
        // Register a user for login tests
        await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'Test User',
        );
      });

      test('should login with correct credentials', () async {
        final user = await authApi.login(
          email: 'test@example.com',
          password: 'password123',
        );

        expect(user.email, 'test@example.com');
        expect(user.displayName, 'Test User');
      });

      test('should normalize email during login', () async {
        final user = await authApi.login(
          email: '  TEST@EXAMPLE.COM  ',
          password: 'password123',
        );

        expect(user.email, 'test@example.com');
      });

      test('should throw AuthFailure for wrong password', () async {
        expect(
          () => authApi.login(
            email: 'test@example.com',
            password: 'wrongpassword',
          ),
          throwsA(isA<AuthFailure>()),
        );
      });

      test('should throw AuthFailure for non-existent email', () async {
        expect(
          () => authApi.login(
            email: 'nonexistent@example.com',
            password: 'password123',
          ),
          throwsA(isA<AuthFailure>()),
        );
      });
    });

    group('Session Management', () {
      test('should restore session after login', () async {
        // Register and login
        await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'Test User',
        );
        
        await authApi.login(
          email: 'test@example.com',
          password: 'password123',
        );

        // Restore session
        final restoredUser = await authApi.restoreSession();
        
        expect(restoredUser, isNotNull);
        expect(restoredUser!.email, 'test@example.com');
        expect(restoredUser.displayName, 'Test User');
      });

      test('should return null when no session exists', () async {
        final restoredUser = await authApi.restoreSession();
        expect(restoredUser, isNull);
      });

      test('should get current user when logged in', () async {
        // Register and login
        await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'Test User',
        );
        
        await authApi.login(
          email: 'test@example.com',
          password: 'password123',
        );

        final currentUser = await authApi.getCurrentUser();
        
        expect(currentUser, isNotNull);
        expect(currentUser!.email, 'test@example.com');
      });

      test('should return null for current user when not logged in', () async {
        final currentUser = await authApi.getCurrentUser();
        expect(currentUser, isNull);
      });

      test('should clear session after logout', () async {
        // Register and login
        await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'Test User',
        );
        
        await authApi.login(
          email: 'test@example.com',
          password: 'password123',
        );

        // Logout
        await authApi.logout();

        // Session should be cleared
        final restoredUser = await authApi.restoreSession();
        expect(restoredUser, isNull);
        
        final currentUser = await authApi.getCurrentUser();
        expect(currentUser, isNull);
      });
    });
  });
}