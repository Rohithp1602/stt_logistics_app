import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../constants/legal_copy.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/driver/bindings/driver_binding.dart';
import '../modules/driver/views/driver_verification_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/views/language_view.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/settings/views/legal_document_view.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/shipment/views/shipment_form_view.dart';
import '../modules/shipment/views/shipment_list_view.dart';
import '../modules/shell/bindings/shell_binding.dart';
import '../modules/shell/views/main_shell_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../services/analytics_service.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Shared [GoRouter] for the web app (URL sync, back/forward, refresh).
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  observers: _analyticsObservers(),
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) {
        SplashBinding().dependencies();
        return const SplashView();
      },
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) {
        OnboardingBinding().dependencies();
        return const OnboardingView();
      },
    ),
    GoRoute(
      path: AppRoutes.language,
      name: 'language',
      builder: (context, state) {
        final fromSettings = state.uri.queryParameters['from'] == 'settings';
        LanguageBinding(fromSettings: fromSettings).dependencies();
        return LanguageView(returnToSettings: fromSettings);
      },
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) {
        AuthBinding().dependencies();
        return const LoginView();
      },
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) {
        AuthBinding().dependencies();
        return const RegisterView();
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        ShellBinding().dependencies();
        return MainShellView(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.shipments,
              name: 'shipments',
              builder: (context, state) => const ShipmentListView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.profile,
              name: 'profile',
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.settings,
              name: 'settings',
              builder: (context, state) => const SettingsView(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.shipmentForm,
      name: 'shipmentForm',
      builder: (context, state) {
        ShellBinding().dependencies();
        return const ShipmentFormView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.driver,
      name: 'driver',
      builder: (context, state) {
        DriverBinding().dependencies();
        return const DriverVerificationView();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.legalPrivacy,
      name: 'legalPrivacy',
      builder: (context, state) => const LegalDocumentView(
        title: LegalCopy.privacyPolicyTitle,
        content: LegalCopy.privacyPolicyContent,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.legalTerms,
      name: 'legalTerms',
      builder: (context, state) => const LegalDocumentView(
        title: LegalCopy.termsOfUseTitle,
        content: LegalCopy.termsOfUseContent,
      ),
    ),
  ],
);

List<NavigatorObserver> _analyticsObservers() {
  if (Get.isRegistered<AnalyticsService>()) {
    return Get.find<AnalyticsService>().navigatorObservers;
  }
  return const <NavigatorObserver>[];
}

/// Imperative navigation helpers for GetX controllers (no BuildContext).
abstract class AppNavigation {
  AppNavigation._();

  static void go(String location) => appRouter.go(location);

  static void goNamed(String name, {Map<String, String>? queryParameters}) {
    appRouter.goNamed(name, queryParameters: queryParameters ?? const {});
  }

  static Future<T?> push<T extends Object?>(String location) =>
      appRouter.push<T>(location);

  static void pop<T extends Object?>([T? result]) {
    if (appRouter.canPop()) {
      appRouter.pop(result);
    }
  }

  static void goShellTab(int index) {
    switch (index) {
      case 0:
        go(AppRoutes.home);
      case 1:
        go(AppRoutes.shipments);
      case 2:
        go(AppRoutes.profile);
      case 3:
        go(AppRoutes.settings);
      default:
        go(AppRoutes.home);
    }
  }
}
