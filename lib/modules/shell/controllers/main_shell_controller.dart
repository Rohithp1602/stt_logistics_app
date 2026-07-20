import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../home/controllers/home_controller.dart';
import '../../shipment/controllers/shipment_controller.dart';

/// Controller for MainShell with bottom navigation.
class MainShellController extends GetxController {
  /// Currently selected tab index (0: Home, 1: Shipments, 2: Profile, 3: Settings)
  final RxInt tabIndex = 0.obs;

  /// Changes the active tab
  void changeTab(int index) {
    tabIndex.value = index;
    if (index == 0 && Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().refreshDashboard();
    }
  }

  /// Opens the shipment creation form (resets create state when controller exists).
  void openCreateShipment() {
    if (Get.isRegistered<ShipmentController>()) {
      Get.find<ShipmentController>().openCreateForm();
      return;
    }
    Get.toNamed(AppRoutes.shipmentForm);
  }
}
