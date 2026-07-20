import 'package:get/get.dart';

import '../../../data/api/auth_api.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/auth_service.dart';
import '../controllers/login_controller.dart';
import '../controllers/register_controller.dart';

/// Registers auth dependencies for the login / register routes.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthApi>()) {
      Get.lazyPut<AuthApi>(HiveAuthApi.new);
    }
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
        () => AuthRepository(
          api: Get.find<AuthApi>(),
          authService: Get.find<AuthService>(),
        ),
      );
    }
    if (!Get.isRegistered<LoginController>()) {
      Get.lazyPut<LoginController>(
        () => LoginController(repository: Get.find<AuthRepository>()),
      );
    }
    if (!Get.isRegistered<RegisterController>()) {
      Get.lazyPut<RegisterController>(
        () => RegisterController(repository: Get.find<AuthRepository>()),
      );
    }
  }
}
