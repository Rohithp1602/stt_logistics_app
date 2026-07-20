import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../services/settings_service.dart';

/// One-time coach mark pointing at the center Add shipment FAB.
class FabTutorialOverlay extends StatelessWidget {
  const FabTutorialOverlay({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Material(
      color: Colors.black.withValues(alpha: 0.72),
      child: Stack(
        children: [
          Positioned(
            left: 24,
            right: 24,
            bottom: bottomPad + 110,
            child: Container(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.fabTutorialTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.fabTutorialBody,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onDismiss,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.accent,
                      ),
                      child: Text(
                        l10n.fabTutorialGotIt,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            // Align with TrendyBottomNav FAB: bar height 80, FAB top:12, size 56
            // → FAB center is bottomPad + 40 from screen bottom.
            bottom: bottomPad + 12,
            left: size.width / 2 - 28,
            child: IgnorePointer(
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.55),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showIfNeeded(BuildContext context) async {
    final settings = Get.find<SettingsService>();
    if (settings.fabTutorialSeen) return;

    // Claim immediately so a shell remount cannot stack another dialog.
    await settings.markFabTutorialSeen();

    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (!context.mounted) return;

    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return FabTutorialOverlay(
          onDismiss: () {
            if (ctx.mounted) Navigator.of(ctx).pop();
          },
        );
      },
    );
  }
}
