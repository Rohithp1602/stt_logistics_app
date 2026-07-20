import '../models/driver_model.dart';
import '../providers/driver_provider.dart';

/// Driver profile use-cases exposed to controllers.
class DriverRepository {
  DriverRepository({required this._provider});

  final DriverProvider _provider;

  /// Returns the current driver verification profile.
  Future<DriverModel> getDriver() => _provider.fetchDriver();

  /// Persists updates to the driver profile.
  Future<void> updateDriver(DriverModel driver) => _provider.saveDriver(driver);
}
