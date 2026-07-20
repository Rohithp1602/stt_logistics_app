import 'package:get/get.dart';

import '../../core/errors/failures.dart';
import '../../services/auth_service.dart';
import '../local/hive_database.dart';
import '../models/shipment_model.dart';

/// Local Hive data source for shipment CRUD operations.
class ShipmentProvider {
  AuthService? get _auth =>
      Get.isRegistered<AuthService>() ? Get.find<AuthService>() : null;

  String _requireUserId() {
    final id = _auth?.currentUser.value?.id;
    if (id == null || id.isEmpty) {
      throw const StorageFailure('Not authenticated');
    }
    return id;
  }

  /// Returns shipments owned by the current user (empty when none).
  Future<List<ShipmentModel>> fetchAll() async {
    final userId = _requireUserId();
    final items = <ShipmentModel>[];
    for (final value in HiveDatabase.shipments.values) {
      try {
        final map = Map<String, dynamic>.from(value);
        final model = ShipmentModel.fromMap(map);
        if (model.userId == userId) {
          items.add(model);
        }
      } catch (_) {
        // Skip malformed rows.
      }
    }
    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  /// Inserts [shipment] and returns the owner's updated list.
  Future<List<ShipmentModel>> create(ShipmentModel shipment) async {
    _requireUserId();
    await HiveDatabase.shipments.put(shipment.id, shipment.toMap());
    return fetchAll();
  }

  /// Replaces [shipment] when owned by the current user.
  Future<List<ShipmentModel>> update(ShipmentModel shipment) async {
    final userId = _requireUserId();
    final raw = HiveDatabase.shipments.get(shipment.id);
    if (raw == null) {
      throw const StorageFailure('Shipment not found');
    }
    final existing =
        ShipmentModel.fromMap(Map<String, dynamic>.from(raw));
    if (existing.userId != userId) {
      throw const StorageFailure('Shipment not found');
    }
    await HiveDatabase.shipments.put(shipment.id, shipment.toMap());
    return fetchAll();
  }

  /// Removes the shipment with [id] when owned by the current user.
  Future<List<ShipmentModel>> delete(String id) async {
    final userId = _requireUserId();
    final raw = HiveDatabase.shipments.get(id);
    if (raw == null) {
      throw const StorageFailure('Shipment not found');
    }
    final existing =
        ShipmentModel.fromMap(Map<String, dynamic>.from(raw));
    if (existing.userId != userId) {
      throw const StorageFailure('Shipment not found');
    }
    await HiveDatabase.shipments.delete(id);
    return fetchAll();
  }
}
