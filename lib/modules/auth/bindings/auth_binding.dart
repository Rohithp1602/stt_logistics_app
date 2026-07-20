import 'package:get/get.dart';

import '../../../data/api/auth_api.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../services/auth_service.dart';
import '../controllers/login_controller.dart';
import '../controllers/register_controller.dart';

/// Registers auth dependencies for the login route.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthApi>()) {
      Get.lazyPut<AuthApi>(HiveAuthApi.new);
    }
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        api: Get.find<AuthApi>(),
        authService: Get.find<AuthService>(),
      ),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(repository: Get.find<AuthRepository>()),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(repository: Get.find<AuthRepository>()),
    );
  }
}
