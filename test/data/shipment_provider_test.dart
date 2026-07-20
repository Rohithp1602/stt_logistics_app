import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:stt_logistics_app/core/enums/shipment_status.dart';
import 'package:stt_logistics_app/core/errors/failures.dart';
import 'package:stt_logistics_app/data/local/hive_boxes.dart';
import 'package:stt_logistics_app/data/models/shipment_model.dart';
import 'package:stt_logistics_app/data/models/user_model.dart';
import 'package:stt_logistics_app/data/providers/shipment_provider.dart';
import 'package:stt_logistics_app/services/auth_service.dart';

void main() {
  group('ShipmentProvider', () {
    late Directory tempDir;
    late ShipmentProvider provider;
    late AuthService authService;

    final userA = UserModel(
      id: 'user-a',
      email: 'a@example.com',
      displayName: 'User A',
    );
    final userB = UserModel(
      id: 'user-b',
      email: 'b@example.com',
      displayName: 'User B',
    );

    ShipmentModel shipmentFor(
      String id,
      String userId, {
      String createdAt = '2026-07-21T10:00:00.000Z',
    }) {
      return ShipmentModel(
        id: id,
        userId: userId,
        customerName: 'Acme',
        origin: 'Dallas, TX',
        destination: 'Houston, TX',
        status: ShipmentStatus.pending,
        createdAt: createdAt,
        updatedAt: createdAt,
      );
    }

    setUp(() async {
      Get.reset();
      tempDir = Directory.systemTemp.createTempSync();
      Hive.init(tempDir.path);
      await Hive.openBox<Map>(HiveBoxes.shipments);
      await Hive.openBox(HiveBoxes.session);

      authService = Get.put<AuthService>(AuthService(), permanent: true);
      await authService.setSession(userA);
      provider = ShipmentProvider();
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      Get.reset();
    });

    test('fetchAll returns empty when box empty', () async {
      expect(await provider.fetchAll(), isEmpty);
    });

    test('create persists and fetchAll returns it for owner', () async {
      final created = shipmentFor('SHP-1', userA.id);
      final items = await provider.create(created);

      expect(items, hasLength(1));
      expect(items.first.id, 'SHP-1');
      expect(items.first.userId, userA.id);

      final raw = Hive.box<Map>(HiveBoxes.shipments).get('SHP-1');
      expect(raw, isNotNull);
      expect(raw!['user_id'], userA.id);
    });

    test('fetchAll does not return other users shipments', () async {
      await Hive.box<Map>(HiveBoxes.shipments).put(
        'SHP-b',
        shipmentFor('SHP-b', userB.id).toMap(),
      );

      expect(await provider.fetchAll(), isEmpty);
    });

    test('update throws StorageFailure for other users id', () async {
      await Hive.box<Map>(HiveBoxes.shipments).put(
        'SHP-b',
        shipmentFor('SHP-b', userB.id).toMap(),
      );

      expect(
        () => provider.update(shipmentFor('SHP-b', userA.id)),
        throwsA(isA<StorageFailure>()),
      );
    });

    test('delete throws StorageFailure for other users id', () async {
      await Hive.box<Map>(HiveBoxes.shipments).put(
        'SHP-b',
        shipmentFor('SHP-b', userB.id).toMap(),
      );

      expect(
        () => provider.delete('SHP-b'),
        throwsA(isA<StorageFailure>()),
      );
    });

    test('fetchAll throws StorageFailure when logged out', () async {
      await authService.clearSession();

      expect(
        () => provider.fetchAll(),
        throwsA(isA<StorageFailure>()),
      );
    });

    test('update and delete succeed for owner', () async {
      await provider.create(shipmentFor('SHP-1', userA.id));

      final updated = shipmentFor('SHP-1', userA.id).copyWith(
        status: ShipmentStatus.delivered,
        updatedAt: '2026-07-21T12:00:00.000Z',
      );
      final afterUpdate = await provider.update(updated);
      expect(afterUpdate.first.status, ShipmentStatus.delivered);

      final afterDelete = await provider.delete('SHP-1');
      expect(afterDelete, isEmpty);
    });
  });
}
