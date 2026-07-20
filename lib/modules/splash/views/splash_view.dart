import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../l10n/l10n.dart';
import '../../../widgets/responsive_page.dart';
import '../controllers/splash_controller.dart';

/// Branded launch screen shown while the app restores session state.
class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final bp = ResponsivePage.breakpointOf(context);
    final logoSize = switch (bp) {
      AppBreakpoint.desktop => 180.0,
      AppBreakpoint.tablet => 160.0,
      AppBreakpoint.mobile => 140.0,
    };

    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: bp == AppBreakpoint.mobile ? 360 : 520,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.splashLogo,
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.local_shipping_rounded,
                    size: logoSize * 0.5,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: bp == AppBreakpoint.mobile ? 20 : 28),
                Text(
                  strings.appName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: bp == AppBreakpoint.desktop ? 36 : 28,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  strings.splashTagline,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                        fontSize: bp == AppBreakpoint.mobile ? 14 : 16,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: bp == AppBreakpoint.mobile ? 32 : 40),
                const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    color: AppColors.accent,
                    backgroundColor: Colors.white24,
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
