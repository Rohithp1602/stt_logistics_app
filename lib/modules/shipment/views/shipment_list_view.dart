import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/l10n.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/loading_overlay.dart';
import '../controllers/shipment_controller.dart';
import '../widgets/shipment_tile.dart';

/// Dashboard listing all shipments with create / edit / delete actions.
class ShipmentListView extends GetView<ShipmentController> {
  const ShipmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(strings.shipments)),
      body: Obx(() {
        if (controller.isLoading.value && controller.shipments.isEmpty) {
          return const LoadingOverlay();
        }

        if (controller.shipments.isEmpty) {
          return EmptyState(
            title: strings.noShipments,
            subtitle: strings.createFirstShipment,
            actionLabel: strings.addShipment,
            onAction: controller.openCreateForm,
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.shipments.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final shipment = controller.shipments[index];
            return ShipmentTile(
              shipment: shipment,
              onTap: () => controller.openEditForm(shipment),
              onDelete: () => controller.deleteShipment(shipment),
              onStatusChanged: (status) =>
                  controller.updateStatus(shipment, status),
            );
          },
        );
      }),
    );
  }
}
