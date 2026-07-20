import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'app.dart';
import 'data/api/auth_api.dart';
import 'data/local/hive_boxes.dart';
import 'data/local/hive_database.dart';
import 'firebase_options.dart';
import 'services/analytics_service.dart';
import 'services/auth_service.dart';
import 'services/crashlytics_service.dart';
import 'services/firebase_messaging_background.dart';
import 'services/messaging_service.dart';
import 'services/performance_service.dart';
import 'services/screenshot_tour_service.dart';
import 'services/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final crashlytics = Get.put(CrashlyticsService(), permanent: true);
  await crashlytics.init();
  Get.put(AnalyticsService(), permanent: true);
  Get.put(PerformanceService(), permanent: true);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await HiveDatabase.init();

  Get.put<AuthApi>(HiveAuthApi(), permanent: true);
  Get.put<SettingsService>(SettingsService(), permanent: true);
  Get.put<AuthService>(AuthService(), permanent: true);

  await Get.putAsync<MessagingService>(
    () => MessagingService().init(),
    permanent: true,
  );

  if (ScreenshotTourService.enabled) {
    // Fresh first-run for onboarding screenshots.
    final settings = Get.find<SettingsService>();
    await Hive.box(HiveBoxes.settings).clear();
    settings.onInit();
    Get.put(ScreenshotTourService(), permanent: true);
  }

  runApp(const SttApp());

  if (ScreenshotTourService.enabled) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ScreenshotTourService>().start();
    });
  }
}
