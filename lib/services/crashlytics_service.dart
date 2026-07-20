import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Firebase Crashlytics facade + global error hooks.
class CrashlyticsService extends GetxService {
  CrashlyticsService({bool enabled = true}) : _enabled = enabled;

  final bool _enabled;

  FirebaseCrashlytics? get _crash {
    if (!_enabled) return null;
    return FirebaseCrashlytics.instance;
  }

  /// Installs Flutter + platform error handlers. Call once after Firebase init.
  Future<void> init() async {
    if (!_enabled) return;
    try {
      FlutterError.onError = (details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    } catch (_) {}
  }

  Future<void> setUser(String userId) async {
    try {
      await _crash?.setUserIdentifier(userId);
    } catch (_) {}
  }

  Future<void> clearUser() async {
    try {
      await _crash?.setUserIdentifier('');
    } catch (_) {}
  }

  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    bool fatal = false,
  }) async {
    try {
      await _crash?.recordError(error, stack, fatal: fatal);
    } catch (_) {}
  }
}
