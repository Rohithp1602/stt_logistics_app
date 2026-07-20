import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

/// Layout breakpoints for adaptive UI.
enum AppBreakpoint {
  mobile,
  tablet,
  desktop,
}

/// Centers content and caps width for readable web layouts.
class ResponsivePage extends StatelessWidget {
  const ResponsivePage({
    super.key,
    required this.child,
    this.maxWidth = 1040,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1024;
  static const double shellBreakpoint = 900;

  static AppBreakpoint breakpointOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return AppBreakpoint.desktop;
    if (width >= tabletBreakpoint) return AppBreakpoint.tablet;
    return AppBreakpoint.mobile;
  }

  static bool isMobile(BuildContext context) =>
      breakpointOf(context) == AppBreakpoint.mobile;

  static bool isTablet(BuildContext context) =>
      breakpointOf(context) == AppBreakpoint.tablet;

  static bool isDesktop(BuildContext context) =>
      breakpointOf(context) == AppBreakpoint.desktop;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= shellBreakpoint;

  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: padding == null
            ? child
            : Padding(padding: padding!, child: child),
      ),
    );
  }
}

/// Pre-auth / marketing canvas: full-bleed on phone, framed panel on tablet/desktop.
class AdaptiveCanvas extends StatelessWidget {
  const AdaptiveCanvas({
    super.key,
    required this.child,
    this.maxWidth = 520,
    this.backgroundColor = AppColors.background,
    this.panelColor = AppColors.surface,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final Color backgroundColor;
  final Color panelColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsivePage.isCompact(context);
    if (compact) {
      return ColoredBox(
        color: backgroundColor,
        child: padding == null ? child : Padding(padding: padding!, child: child),
      );
    }

    return ColoredBox(
      color: backgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Material(
            color: panelColor,
            elevation: 2,
            shadowColor: Colors.black26,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: padding == null
                ? child
                : Padding(padding: padding!, child: child),
          ),
        ),
      ),
    );
  }
}

/// Split brand + content layout for desktop/tablet auth flows.
class AuthSplitScaffold extends StatelessWidget {
  const AuthSplitScaffold({
    super.key,
    required this.child,
    this.contentMaxWidth = 480,
  });

  final Widget child;
  final double contentMaxWidth;

  @override
  Widget build(BuildContext context) {
    final bp = ResponsivePage.breakpointOf(context);
    if (bp == AppBreakpoint.mobile) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(child: child),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Expanded(
            flex: bp == AppBreakpoint.desktop ? 5 : 4,
            child: const _BrandPanel(),
          ),
          Expanded(
            flex: bp == AppBreakpoint.desktop ? 5 : 6,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: bp == AppBreakpoint.desktop ? 40 : 28,
                      vertical: 24,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandPanel extends StatelessWidget {
  const _BrandPanel();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
            Color(0xFF020817),
          ],
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final showCopy = constraints.maxWidth >= 220;
            return Padding(
              padding: EdgeInsets.all(showCopy ? 40 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAssets.logo,
                    width: showCopy ? 64 : 48,
                    height: showCopy ? 64 : 48,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.local_shipping_rounded,
                      color: Colors.white,
                      size: showCopy ? 48 : 36,
                    ),
                  ),
                  const Spacer(),
                  if (showCopy) ...[
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'STT Logistics',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Driver verification and shipment tracking built for modern fleets.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.78),
                        fontSize: 16,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Brand sidebar used on wide viewports.
class AppSideNav extends StatelessWidget {
  const AppSideNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAdd,
    required this.homeLabel,
    required this.shipmentsLabel,
    required this.profileLabel,
    required this.settingsLabel,
    required this.newShipmentLabel,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAdd;
  final String homeLabel;
  final String shipmentsLabel;
  final String profileLabel;
  final String settingsLabel;
  final String newShipmentLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: SafeArea(
        child: SizedBox(
          width: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Text(
                  'STT Logistics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _item(0, Icons.home_outlined, homeLabel),
              _item(1, Icons.local_shipping_outlined, shipmentsLabel),
              _item(2, Icons.person_outline, profileLabel),
              _item(3, Icons.settings_outlined, settingsLabel),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add),
                  label: Text(newShipmentLabel),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(int index, IconData icon, String label) {
    final selected = currentIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.primary : AppColors.textPrimary,
        ),
      ),
      selected: selected,
      selectedTileColor: AppColors.primary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () => onTap(index),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
