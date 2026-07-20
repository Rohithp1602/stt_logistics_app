import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/l10n.dart';
import '../../../widgets/loading_overlay.dart';
import '../controllers/driver_controller.dart';
import '../widgets/driver_verification_card.dart';

/// Screen that presents the STT driver verification license cards.
class DriverVerificationView extends GetView<DriverController> {
  const DriverVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(strings.driverVerification)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingOverlay();
        }

        final driver = controller.driver.value;
        if (driver == null) {
          return Center(child: Text(strings.driverProfileUnavailable));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Front',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            DriverVerificationCard(driver: driver),
            const SizedBox(height: 20),
            const Text(
              'Back',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            DriverLicenseBackCard(driver: driver),
            const SizedBox(height: 16),
          ],
        );
      }),
    );
  }
}
