import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/onboarding_assets.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';

class OnboardingController extends GetxController {
  final pageIndex = 0.obs;
  final isFinishing = false.obs;
  final pageController = PageController();

  void onPageChanged(int index) => pageIndex.value = index;

  Future<void> finish() async {
    if (isFinishing.value) return;
    isFinishing.value = true;
    try {
      await Get.find<SettingsService>().completeOnboarding();
      Get.offAllNamed(AppRoutes.language);
    } catch (_) {
      if (!isClosed) isFinishing.value = false;
      rethrow;
    }
  }

  void next(AppLocalizations l10n) {
    if (isFinishing.value) return;
    if (pageIndex.value == 0) {
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      finish();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(OnboardingController.new);
  }
}

/// Two-page onboarding matching STT brand designs.
class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: PageView(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          children: [
            _OnboardingPageOne(
              l10n: l10n,
              onGetStarted: () => controller.next(l10n),
              onSkip: controller.finish,
            ),
            _OnboardingPageTwo(
              l10n: l10n,
              onContinue: () => controller.next(l10n),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageOne extends StatelessWidget {
  const _OnboardingPageOne({
    required this.l10n,
    required this.onGetStarted,
    required this.onSkip,
  });

  final AppLocalizations l10n;
  final VoidCallback onGetStarted;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topInset = MediaQuery.paddingOf(context).top;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    // Hero circle sits in the upper half; copy lives fully on black.
    final heroBottom = size.height * 0.58;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          children: [
            // Light wash behind logo + upper half of the circular hero.
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: heroBottom * 0.72,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFDCDCDC),
                      Color(0xFFF2F2F2),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                ),
              ),
            ),

            // Circular hero (asset already has transparent corners).
            Positioned(
              top: topInset + 4,
              left: 0,
              right: 0,
              height: heroBottom - topInset,
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  Image.asset(
                    OnboardingAssets.logo,
                    height: 48,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(height: 48),
                  ),
                  Expanded(
                    child: Image.asset(
                      OnboardingAssets.heroTruck,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom copy + actions — left-aligned text, centered controls.
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 6 + bottomInset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${l10n.onboardingTitle1Line1}\n',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                              letterSpacing: -0.4,
                            ),
                          ),
                          TextSpan(
                            text: l10n.onboardingTitle1Line2,
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.onboardingSubtitle1,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _Dot(active: true),
                          SizedBox(width: 8),
                          _Dot(active: false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: onGetStarted,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          l10n.getStarted,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: TextButton(
                        onPressed: onSkip,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFA8A8A8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                        ),
                        child: Text(
                          l10n.skip,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageTwo extends StatelessWidget {
  const _OnboardingPageTwo({
    required this.l10n,
    required this.onContinue,
  });

  final AppLocalizations l10n;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.sizeOf(context).height * 0.38,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  OnboardingAssets.bgFeatures,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: topInset + 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${l10n.onboardingTitle2Line1}\n',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                                letterSpacing: -0.2,
                              ),
                            ),
                            TextSpan(
                              text: l10n.onboardingTitle2Line2,
                              style: const TextStyle(
                                color: AppColors.accent,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.onboardingSubtitle2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 13.5,
                          height: 1.45,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        _FeatureCard(
                          icon: OnboardingAssets.iconVerification,
                          title: l10n.featureDriverTitle,
                          body: l10n.featureDriverBody,
                        ),
                        const SizedBox(height: 12),
                        _FeatureCard(
                          icon: OnboardingAssets.iconTruck,
                          title: l10n.featureShipmentTitle,
                          body: l10n.featureShipmentBody,
                        ),
                        const SizedBox(height: 12),
                        _FeatureCard(
                          icon: OnboardingAssets.iconRealtime,
                          title: l10n.featureRealtimeTitle,
                          body: l10n.featureRealtimeBody,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                ClipPath(
                  clipper: const _TopConcaveWaveClipper(),
                  child: Container(
                    width: double.infinity,
                    color: AppColors.accent,
                    padding: EdgeInsets.fromLTRB(24, 36, 24, 18 + bottomInset),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _Dot(active: false, onAccent: true),
                            SizedBox(width: 8),
                            _Dot(active: true, onAccent: true),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: onContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              l10n.continueLabel,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final String icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0A111A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              icon,
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.5,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    height: 1.35,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.active,
    this.onAccent = false,
  });

  final bool active;
  final bool onAccent;

  @override
  Widget build(BuildContext context) {
    final Color color;
    if (onAccent) {
      // On red footer: active = black, inactive = white (matches mock)
      color = active ? Colors.black : Colors.white;
    } else {
      // On black footer: active = red, inactive = white
      color = active ? AppColors.accent : Colors.white;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: active ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

/// Concave upward wave for the red page-2 footer.
class _TopConcaveWaveClipper extends CustomClipper<Path> {
  const _TopConcaveWaveClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    final dip = math.min(48.0, size.height * 0.36);
    path.moveTo(0, dip);
    path.quadraticBezierTo(
      size.width * 0.5,
      4,
      size.width,
      dip,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
