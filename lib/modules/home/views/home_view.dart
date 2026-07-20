import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../core/enums/verification_status.dart';
import '../../../l10n/l10n.dart';
import '../../../theme/app_decorations.dart';
import '../../driver/widgets/driver_verification_card.dart';
import '../../shipment/controllers/shipment_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/shipment_overview_card.dart';

/// Home dashboard with shipment overview and driver card.
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                AppAssets.logo,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.local_shipping_rounded,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(child: Text(strings.appName)),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: controller.refreshDashboard,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppDecorations.pagePadding,
          children: [
            _WelcomeHeader(name: controller.userLabel),
            const SizedBox(height: 20),
            Obx(() {
              if (Get.isRegistered<ShipmentController>()) {
                Get.find<ShipmentController>().shipments.length;
              }
              return ShipmentOverviewCard(
                total: controller.totalShipments,
                pending: controller.pendingShipments,
                inTransit: controller.inTransitShipments,
                delivered: controller.deliveredShipments,
                onTap: controller.openShipments,
              );
            }),
            const SizedBox(height: 22),
            Row(
              children: [
                Text(
                  strings.driverVerification,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                Obx(() {
                  final status = controller.verificationStatus;
                  return _StatusChip(status: status);
                }),
              ],
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (controller.isLoadingDriver.value &&
                  controller.driver.value == null) {
                return const SizedBox(
                  height: 160,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final driver = controller.driver.value;
              if (driver == null) {
                return _EmptyDriverCard(
                  onTap: controller.openDriverVerification,
                );
              }
              return DriverVerificationCard(
                driver: driver,
                compact: true,
                onTap: controller.openDriverVerification,
              );
            }),
            const SizedBox(height: 8),
            Text(
              strings.tapCardForLicense,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.welcomeBack,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            strings.appTagline,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final VerificationStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      VerificationStatus.verified => AppColors.verified,
      VerificationStatus.pending => AppColors.pending,
      VerificationStatus.rejected => AppColors.rejected,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        status.localizedLabel(context.l10n),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _EmptyDriverCard extends StatelessWidget {
  const _EmptyDriverCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kDriverLicenseCardMaxWidth),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Ink(
              height: 140,
              decoration: AppDecorations.card,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    context.l10n.completeProfileForLicense,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
