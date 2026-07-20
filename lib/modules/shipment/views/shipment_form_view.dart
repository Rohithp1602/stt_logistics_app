import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enums/shipment_status.dart';
import '../../../l10n/l10n.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../controllers/shipment_controller.dart';

/// Create / edit form for a single shipment record.
class ShipmentFormView extends GetView<ShipmentController> {
  const ShipmentFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isEditing = controller.editingShipment != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? strings.editShipment : strings.addShipment,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppTextField(
                controller: controller.customerController,
                label: strings.customerName,
                validator: controller.validateCustomer,
                prefixIcon: Icons.business_outlined,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: controller.originController,
                label: strings.origin,
                validator: controller.validateOrigin,
                prefixIcon: Icons.trip_origin,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: controller.destinationController,
                label: strings.destination,
                validator: controller.validateDestination,
                prefixIcon: Icons.flag_outlined,
              ),
              const SizedBox(height: 16),
              Text(strings.status, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Obx(
                () => DropdownButtonFormField<ShipmentStatus>(
                  key: ValueKey(controller.formStatus.value),
                  initialValue: controller.formStatus.value,
                  items: ShipmentStatus.values
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(status.localizedLabel(strings)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) controller.formStatus.value = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => AppButton(
                  label: isEditing ? strings.updateShipment : strings.saveShipment,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.saveShipment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
