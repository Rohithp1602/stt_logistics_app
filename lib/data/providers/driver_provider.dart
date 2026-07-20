import 'package:get/get.dart';

import '../../core/enums/verification_status.dart';
import '../../core/errors/failures.dart';
import '../../data/local/hive_database.dart';
import '../../data/models/user_model.dart';
import '../../services/auth_service.dart';
import '../models/driver_model.dart';

/// Local data source for the current driver's verification profile.
class DriverProvider {
  AuthService? get _auth =>
      Get.isRegistered<AuthService>() ? Get.find<AuthService>() : null;

  /// Loads the driver profile for the active session.
  Future<DriverModel> fetchDriver() async {
    final user = _auth?.currentUser.value;
    if (user == null) {
      throw const StorageFailure('Not authenticated');
    }
    return _fetchDriverForUser(user);
  }

  DriverModel _fetchDriverForUser(UserModel user) {
    final raw = HiveDatabase.drivers.get(user.id);
    if (raw != null) {
      return DriverModel.fromMap(Map<String, dynamic>.from(raw));
    }

    return _pendingProfileForUser(user);
  }

  DriverModel _pendingProfileForUser(UserModel user) {
    final displayName = user.displayName?.trim();
    return DriverModel(
      userId: user.id,
      name: displayName != null && displayName.isNotEmpty
          ? displayName
          : user.email,
      phone: user.phone,
      cdlNumber: '',
      hub: '',
      status: VerificationStatus.pending,
      photoPath: user.photoPath,
    );
  }

  /// Persists [driver] to Hive for the logged-in user.
  Future<void> saveDriver(DriverModel driver) async {
    final user = _auth?.currentUser.value;
    if (user == null) {
      throw const StorageFailure('Not authenticated');
    }

    final toSave =
        driver.userId.isEmpty ? driver.copyWith(userId: user.id) : driver;
    await HiveDatabase.drivers.put(user.id, toSave.toMap());
  }
}
