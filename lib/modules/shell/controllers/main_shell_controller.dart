import 'package:get/get.dart';

import '../../../routes/app_router.dart';
import '../../../routes/app_routes.dart';
import '../../home/controllers/home_controller.dart';
import '../../shipment/controllers/shipment_controller.dart';

/// Controller for MainShell with bottom / side navigation.
class MainShellController extends GetxController {
  /// Currently selected tab index (0: Home, 1: Shipments, 2: Profile, 3: Settings)
  final RxInt tabIndex = 0.obs;

  /// Changes the active tab (URL update is handled by the shell view).
  void changeTab(int index) {
    tabIndex.value = index;
    if (index == 0 && Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().refreshDashboard();
    }
  }

  /// Opens the shipment creation form.
  void openCreateShipment() {
    if (Get.isRegistered<ShipmentController>()) {
      Get.find<ShipmentController>().openCreateForm();
      return;
    }
    AppNavigation.go(AppRoutes.shipmentForm);
  }
}
