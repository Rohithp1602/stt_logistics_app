import '../models/shipment_model.dart';
import '../providers/shipment_provider.dart';

/// Shipment CRUD use-cases exposed to controllers.
class ShipmentRepository {
  ShipmentRepository({required this._provider});

  final ShipmentProvider _provider;

  /// Loads all shipments from local storage.
  Future<List<ShipmentModel>> getAll() => _provider.fetchAll();

  /// Creates a new shipment record.
  Future<List<ShipmentModel>> create(ShipmentModel shipment) =>
      _provider.create(shipment);

  /// Updates an existing shipment record.
  Future<List<ShipmentModel>> update(ShipmentModel shipment) =>
      _provider.update(shipment);

  /// Deletes a shipment by [id].
  Future<List<ShipmentModel>> delete(String id) => _provider.delete(id);
}
