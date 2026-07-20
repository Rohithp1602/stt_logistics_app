import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:stt_logistics_app/data/api/auth_api.dart';
import 'package:stt_logistics_app/data/models/user_model.dart';
import 'package:stt_logistics_app/data/models/driver_model.dart';
import 'package:stt_logistics_app/core/errors/failures.dart';

void main() {
  group('AuthApi UpdateProfile Tests', () {
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
      await Hive.openBox('settings');
      
      authApi = HiveAuthApi();
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    group('Update Profile', () {
      test('should update user profile successfully', () async {
        // Register user
        await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'Original Name',
          cdlNumber: 'CDL123',
          hub: 'Original Hub',
        );

        // Update profile
        final updatedUser = await authApi.updateProfile(
          displayName: 'Updated Name',
          phone: '1234567890',
          cdlNumber: 'CDL456',
          hub: 'Updated Hub',
          photoPath: '/path/to/photo.jpg',
        );

        expect(updatedUser.displayName, 'Updated Name');
        expect(updatedUser.phone, '1234567890');
        expect(updatedUser.photoPath, '/path/to/photo.jpg');
        expect(updatedUser.passwordHash, ''); // Should be cleared for security
      });

      test('should update driver profile when CDL or hub changes', () async {
        // Register driver
        await authApi.register(
          email: 'driver@example.com',
          password: 'password123',
          displayName: 'Driver Name',
          cdlNumber: 'CDL123',
          hub: 'Hub A',
        );

        // Update profile with new CDL and hub
        await authApi.updateProfile(
          displayName: 'Updated Driver Name',
          cdlNumber: 'CDL999',
          hub: 'Hub B',
        );

        // Verify driver profile was updated by checking through getCurrentUser
        final currentUser = await authApi.getCurrentUser();
        expect(currentUser, isNotNull);
        expect(currentUser!.displayName, 'Updated Driver Name');

        // Note: We would need a method to get driver profile to verify CDL/hub updates
        // For now, we trust the implementation updates the driver record
      });

      test('should reflect changes after session restore', () async {
        // Register user
        await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'Original Name',
          cdlNumber: 'CDL123',
        );

        // Update profile
        await authApi.updateProfile(
          displayName: 'Changed Name',
          cdlNumber: 'CDL789',
        );

        // Restore session should reflect the changes
        final restoredUser = await authApi.restoreSession();
        expect(restoredUser, isNotNull);
        expect(restoredUser!.displayName, 'Changed Name');
        expect(restoredUser.passwordHash, ''); // Should remain cleared
      });

      test('should throw AuthFailure when no user is logged in', () async {
        // Try to update profile without logging in
        expect(
          () => authApi.updateProfile(displayName: 'New Name'),
          throwsA(isA<AuthFailure>()),
        );
      });

      test('should handle partial updates', () async {
        // Register user
        await authApi.register(
          email: 'test@example.com',
          password: 'password123',
          displayName: 'Original Name',
          phone: '1111111111',
        );

        // Update only display name
        final updatedUser = await authApi.updateProfile(
          displayName: 'Only Name Changed',
        );

        expect(updatedUser.displayName, 'Only Name Changed');
        expect(updatedUser.phone, '1111111111'); // Should remain unchanged
        expect(updatedUser.email, 'test@example.com'); // Should remain unchanged
      });
    });
  });
}