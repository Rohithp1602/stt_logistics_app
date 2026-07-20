import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:stt_logistics_app/core/enums/verification_status.dart';
import 'package:stt_logistics_app/core/errors/failures.dart';
import 'package:stt_logistics_app/data/local/hive_boxes.dart';
import 'package:stt_logistics_app/data/models/driver_model.dart';
import 'package:stt_logistics_app/data/models/user_model.dart';
import 'package:stt_logistics_app/data/providers/driver_provider.dart';
import 'package:stt_logistics_app/services/auth_service.dart';

void main() {
  group('DriverProvider', () {
    late Directory tempDir;
    late DriverProvider provider;
    late AuthService authService;

    setUp(() async {
      Get.reset();
      tempDir = Directory.systemTemp.createTempSync();
      Hive.init(tempDir.path);
      await Hive.openBox<Map>(HiveBoxes.users);
      await Hive.openBox<Map>(HiveBoxes.drivers);
      await Hive.openBox(HiveBoxes.session);

      authService = Get.put<AuthService>(AuthService(), permanent: true);
      provider = DriverProvider();
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      Get.reset();
    });

    test('throws StorageFailure when logged out', () async {
      expect(
        () => provider.fetchDriver(),
        throwsA(isA<StorageFailure>()),
      );
    });

    test('returns Hive driver for logged-in user by userId', () async {
      final user = UserModel(
        id: 'user-123',
        email: 'driver@example.com',
        displayName: 'Alex Rivera',
      );
      await authService.setSession(user);

      final hiveDriver = DriverModel(
        userId: user.id,
        name: 'Alex Rivera',
        cdlNumber: 'CDL-999',
        hub: 'Austin Hub — TX',
        status: VerificationStatus.verified,
        photoPath: '/tmp/photo.jpg',
      );
      await Hive.box<Map>(HiveBoxes.drivers).put(user.id, hiveDriver.toMap());

      final driver = await provider.fetchDriver();

      expect(driver.name, 'Alex Rivera');
      expect(driver.cdlNumber, 'CDL-999');
      expect(driver.hub, 'Austin Hub — TX');
      expect(driver.status, VerificationStatus.verified);
      expect(driver.photoPath, '/tmp/photo.jpg');
    });

    test('returns pending profile when logged in without Hive driver row',
        () async {
      final user = UserModel(
        id: 'user-456',
        email: 'pending@example.com',
        displayName: 'Pending Driver',
      );
      await authService.setSession(user);

      final driver = await provider.fetchDriver();

      expect(driver.name, 'Pending Driver');
      expect(driver.userId, 'user-456');
      expect(driver.cdlNumber, isEmpty);
      expect(driver.hub, isEmpty);
      expect(driver.status, VerificationStatus.pending);
      expect(driver.name, isNot('James Carter'));
    });

    test('saveDriver writes to Hive when logged in', () async {
      final user = UserModel(
        id: 'user-789',
        email: 'save@example.com',
        displayName: 'Save Test',
      );
      await authService.setSession(user);

      const updated = DriverModel(
        name: 'Save Test',
        cdlNumber: 'CDL-111',
        hub: 'Houston Hub — TX',
        status: VerificationStatus.verified,
      );
      await provider.saveDriver(updated);

      final stored = Hive.box<Map>(HiveBoxes.drivers).get(user.id);
      expect(stored, isNotNull);
      expect(stored!['cdl_number'], 'CDL-111');
    });

    test('saveDriver throws StorageFailure when logged out', () async {
      const updated = DriverModel(
        name: 'Save Test',
        cdlNumber: 'CDL-111',
        hub: 'Houston Hub — TX',
        status: VerificationStatus.verified,
      );

      expect(
        () => provider.saveDriver(updated),
        throwsA(isA<StorageFailure>()),
      );
    });
  });
}
