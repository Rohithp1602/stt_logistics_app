import 'package:get/get.dart';

import '../../../data/providers/driver_provider.dart';
import '../../../data/repositories/driver_repository.dart';
import '../controllers/driver_controller.dart';

/// Registers driver feature dependencies.
class DriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverProvider>(DriverProvider.new);
    Get.lazyPut<DriverRepository>(
      () => DriverRepository(provider: Get.find<DriverProvider>()),
    );
    Get.lazyPut<DriverController>(
      () => DriverController(repository: Get.find<DriverRepository>()),
    );
  }
}
