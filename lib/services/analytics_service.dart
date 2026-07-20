import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../constants/analytics_events.dart';
import 'screen_time_observer.dart';

/// Central Firebase Analytics facade.
class AnalyticsService extends GetxService {
  AnalyticsService({bool enabled = true, FirebaseAnalytics? analytics})
      : _enabled = enabled,
        _analytics = analytics;

  final bool _enabled;
  FirebaseAnalytics? _analytics;

  FirebaseAnalytics? get _fa {
    if (!_enabled) return null;
    return _analytics ??= FirebaseAnalytics.instance;
  }

  List<NavigatorObserver> get navigatorObservers {
    final list = <NavigatorObserver>[
      ScreenTimeObserver(
        onScreenTime: (screen, ms) {
          logScreenTime(screenName: screen, durationMs: ms);
        },
        screenNameForRoute: (route) =>
            AnalyticsScreens.fromRoute(route?.settings.name),
      ),
    ];
    final fa = _fa;
    if (fa != null) {
      list.insert(
        0,
        FirebaseAnalyticsObserver(
          analytics: fa,
          nameExtractor: (settings) =>
              AnalyticsScreens.fromRoute(settings.name),
        ),
      );
    }
    return list;
  }

  Future<void> logEvent(
    String name, {
    Map<String, Object>? parameters,
  }) async {
    try {
      await _fa?.logEvent(name: name, parameters: parameters);
    } catch (_) {}
  }

  Future<void> logScreenTime({
    required String screenName,
    required int durationMs,
  }) async {
    await logEvent(
      AnalyticsEvents.screenTime,
      parameters: <String, Object>{
        'screen_name': screenName,
        'duration_ms': durationMs,
      },
    );
  }

  Future<void> setUser(String userId) async {
    try {
      await _fa?.setUserId(id: userId);
      await _fa?.setUserProperty(name: 'login_state', value: 'logged_in');
    } catch (_) {}
  }

  Future<void> clearUser() async {
    try {
      await _fa?.setUserId(id: null);
      await _fa?.setUserProperty(name: 'login_state', value: 'logged_out');
    } catch (_) {}
  }
}
