import 'package:get/get.dart';

import '../../../constants/analytics_events.dart';
import '../../../core/enums/shipment_status.dart';
import '../../../core/enums/verification_status.dart';
import '../../../core/errors/failures.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/models/shipment_model.dart';
import '../../../data/providers/driver_provider.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_routes.dart';
import '../../../services/analytics_service.dart';
import '../../../services/auth_service.dart';
import '../../../utils/snackbar_helper.dart';
import '../../shell/controllers/main_shell_controller.dart';
import '../../shipment/controllers/shipment_controller.dart';

/// Home dashboard: shipment counts and driver verification card.
class HomeController extends GetxController {
  final Rxn<DriverModel> driver = Rxn<DriverModel>();
  final RxBool isLoadingDriver = false.obs;

  AuthService get _auth => Get.find<AuthService>();

  String get userLabel {
    final user = _auth.currentUser.value;
    return user?.displayName ?? user?.email ?? 'Driver';
  }

  List<ShipmentModel> get _shipments {
    if (!Get.isRegistered<ShipmentController>()) {
      return const <ShipmentModel>[];
    }
    return Get.find<ShipmentController>().shipments.toList();
  }

  int get totalShipments => _shipments.length;

  int get pendingShipments =>
      _shipments.where((s) => s.status == ShipmentStatus.pending).length;

  int get inTransitShipments =>
      _shipments.where((s) => s.status == ShipmentStatus.inTransit).length;

  int get deliveredShipments =>
      _shipments.where((s) => s.status == ShipmentStatus.delivered).length;

  VerificationStatus get verificationStatus =>
      driver.value?.status ?? VerificationStatus.pending;

  @override
  void onReady() {
    super.onReady();
    if (Get.isRegistered<AnalyticsService>()) {
      Get.find<AnalyticsService>().logEvent(AnalyticsEvents.flowHomeView);
    }
    refreshDashboard();
  }

  Future<void> refreshDashboard() async {
    if (Get.isRegistered<ShipmentController>()) {
      await Get.find<ShipmentController>().loadShipments();
    }
    await _loadDriver();
  }

  Future<void> _loadDriver() async {
    if (!Get.isRegistered<DriverProvider>()) return;
    isLoadingDriver.value = true;
    try {
      driver.value = await Get.find<DriverProvider>().fetchDriver();
    } on StorageFailure catch (e) {
      SnackbarHelper.error(e.message);
    } finally {
      isLoadingDriver.value = false;
    }
  }

  void openDriverVerification() {
    if (Get.isRegistered<AnalyticsService>()) {
      Get.find<AnalyticsService>().logEvent(AnalyticsEvents.featureOpenDriver);
    }
    AppNavigation.push(AppRoutes.driver);
  }

  void openShipments() {
    if (Get.isRegistered<AnalyticsService>()) {
      Get.find<AnalyticsService>()
          .logEvent(AnalyticsEvents.featureOpenShipments);
    }
    if (Get.isRegistered<MainShellController>()) {
      Get.find<MainShellController>().changeTab(1);
    }
    AppNavigation.go(AppRoutes.shipments);
  }
}
