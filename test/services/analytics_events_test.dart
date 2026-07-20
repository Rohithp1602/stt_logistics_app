import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/constants/analytics_events.dart';
import 'package:stt_logistics_app/routes/app_routes.dart';

void main() {
  test('route map covers all AppRoutes', () {
    expect(AnalyticsScreens.fromRoute(AppRoutes.splash), 'splash');
    expect(AnalyticsScreens.fromRoute(AppRoutes.login), 'login');
    expect(AnalyticsScreens.fromRoute(AppRoutes.home), 'home');
    expect(AnalyticsScreens.fromRoute(AppRoutes.driver), 'driver');
    expect(AnalyticsScreens.fromRoute(AppRoutes.shipments), 'shipments');
    expect(AnalyticsScreens.fromRoute(AppRoutes.shipmentForm), 'shipment_form');
  });

  test('funnel event names are stable', () {
    expect(AnalyticsEvents.flowSplashStart, 'flow_splash_start');
    expect(AnalyticsEvents.flowSplashComplete, 'flow_splash_complete');
    expect(AnalyticsEvents.flowLoginSuccess, 'flow_login_success');
    expect(AnalyticsEvents.flowLoginFail, 'flow_login_fail');
    expect(AnalyticsEvents.flowHomeView, 'flow_home_view');
    expect(AnalyticsEvents.featureOpenDriver, 'feature_open_driver');
    expect(AnalyticsEvents.featureOpenShipments, 'feature_open_shipments');
    expect(AnalyticsEvents.featureOpenShipmentForm, 'feature_open_shipment_form');
    expect(AnalyticsEvents.flowLogout, 'flow_logout');
    expect(AnalyticsEvents.screenTime, 'screen_time');
  });
}
