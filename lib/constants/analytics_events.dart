import '../routes/app_routes.dart';

/// Firebase Analytics event names (snake_case, stable for dashboards).
abstract class AnalyticsEvents {
  static const String screenTime = 'screen_time';
  static const String flowSplashStart = 'flow_splash_start';
  static const String flowSplashComplete = 'flow_splash_complete';
  static const String flowLoginSuccess = 'flow_login_success';
  static const String flowLoginFail = 'flow_login_fail';
  static const String flowRegisterSuccess = 'flow_register_success';
  static const String flowRegisterFail = 'flow_register_fail';
  static const String flowHomeView = 'flow_home_view';
  static const String featureOpenDriver = 'feature_open_driver';
  static const String featureOpenShipments = 'feature_open_shipments';
  static const String featureOpenShipmentForm = 'feature_open_shipment_form';
  static const String flowLogout = 'flow_logout';

  /// Reserved until an onboard screen exists.
  static const String flowOnboardStart = 'flow_onboard_start';
  static const String flowOnboardComplete = 'flow_onboard_complete';
}

/// Human-readable screen names for Analytics.
abstract class AnalyticsScreens {
  static const Map<String, String> routeToName = <String, String>{
    AppRoutes.splash: 'splash',
    AppRoutes.onboarding: 'onboarding',
    AppRoutes.language: 'language',
    AppRoutes.login: 'login',
    AppRoutes.register: 'register',
    AppRoutes.shell: 'shell',
    AppRoutes.home: 'home',
    AppRoutes.driver: 'driver',
    AppRoutes.shipments: 'shipments',
    AppRoutes.shipmentForm: 'shipment_form',
  };

  static String fromRoute(String? route) {
    if (route == null || route.isEmpty) return 'unknown';
    return routeToName[route] ?? route.replaceAll('/', '_').replaceFirst(RegExp(r'^_'), '');
  }
}

/// Firebase Performance custom trace names.
abstract class PerformanceTraces {
  static const String splashBootstrap = 'splash_bootstrap';
  static const String loginSubmit = 'login_submit';
  static const String registerSubmit = 'register_submit';
}
