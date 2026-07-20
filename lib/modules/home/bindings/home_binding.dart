import 'package:get/get.dart';

import '../controllers/home_controller.dart';

/// Registers [HomeController] for the post-login shell.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(HomeController.new);
  }
}
