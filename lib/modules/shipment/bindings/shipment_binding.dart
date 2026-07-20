import 'package:get/get.dart';

import '../../../data/providers/shipment_provider.dart';
import '../../../data/repositories/shipment_repository.dart';
import '../controllers/shipment_controller.dart';

/// Registers shipment feature dependencies.
class ShipmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShipmentProvider>(ShipmentProvider.new, fenix: true);
    Get.lazyPut<ShipmentRepository>(
      () => ShipmentRepository(provider: Get.find<ShipmentProvider>()),
      fenix: true,
    );
    Get.lazyPut<ShipmentController>(
      () => ShipmentController(repository: Get.find<ShipmentRepository>()),
      fenix: true,
    );
  }
}
