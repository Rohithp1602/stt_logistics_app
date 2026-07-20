import 'package:get/get.dart';

import '../../../core/errors/failures.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/repositories/driver_repository.dart';
import '../../../utils/snackbar_helper.dart';

/// Loads and exposes the driver's verification profile.
class DriverController extends GetxController {
  DriverController({required this._repository});

  final DriverRepository _repository;

  final Rxn<DriverModel> driver = Rxn<DriverModel>();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadDriver();
  }

  /// Fetches the driver profile from the repository.
  Future<void> loadDriver() async {
    isLoading.value = true;
    try {
      driver.value = await _repository.getDriver();
    } on StorageFailure catch (e) {
      SnackbarHelper.error(e.message);
    } finally {
      isLoading.value = false;
    }
  }
}
