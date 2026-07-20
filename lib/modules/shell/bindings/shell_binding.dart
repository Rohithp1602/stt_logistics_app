import 'package:get/get.dart';

import '../../../data/api/auth_api.dart';
import '../../../data/providers/driver_provider.dart';
import '../../../data/providers/shipment_provider.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/shipment_repository.dart';
import '../../../services/auth_service.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../shipment/controllers/shipment_controller.dart';
import '../controllers/main_shell_controller.dart';

class ShellBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthApi>()) {
      Get.lazyPut<AuthApi>(HiveAuthApi.new, fenix: true);
    }
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
        () => AuthRepository(
          api: Get.find<AuthApi>(),
          authService: Get.find<AuthService>(),
        ),
        fenix: true,
      );
    }

    Get.lazyPut<MainShellController>(MainShellController.new);
    Get.lazyPut<HomeController>(HomeController.new);

    Get.lazyPut<ShipmentProvider>(ShipmentProvider.new, fenix: true);
    Get.lazyPut<ShipmentRepository>(
      () => ShipmentRepository(provider: Get.find<ShipmentProvider>()),
      fenix: true,
    );
    Get.lazyPut<ShipmentController>(
      () => ShipmentController(repository: Get.find<ShipmentRepository>()),
      fenix: true,
    );

    Get.lazyPut<DriverProvider>(DriverProvider.new, fenix: true);
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
    Get.lazyPut<SettingsController>(SettingsController.new, fenix: true);
  }
}
