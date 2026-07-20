import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

/// Registers [SplashController] for the splash route.
///
/// Uses [Get.put] (eager) rather than [Get.lazyPut]: [SplashView] does not
/// reference `controller` in its build method, so a lazy registration would
/// never instantiate and [SplashController.onReady] would never navigate away.
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
