import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:stt_logistics_app/app.dart';
import 'package:stt_logistics_app/data/api/auth_api.dart';
import 'package:stt_logistics_app/data/local/hive_boxes.dart';
import 'package:stt_logistics_app/routes/app_router.dart';
import 'package:stt_logistics_app/routes/app_routes.dart';
import 'package:stt_logistics_app/services/analytics_service.dart';
import 'package:stt_logistics_app/services/auth_service.dart';
import 'package:stt_logistics_app/services/messaging_service.dart';
import 'package:stt_logistics_app/services/settings_service.dart';

void main() {
  group('Login & Register UI Tests', () {
    late Directory tempDir;

    setUpAll(() async {
      GoogleFonts.config.allowRuntimeFetching = false;
    });

    setUp(() async {
      Get.reset();

      tempDir = Directory.systemTemp.createTempSync('stt_login_ui_');
      Hive.init(tempDir.path);

      await Hive.openBox<Map>('users');
      await Hive.openBox<Map>('drivers');
      await Hive.openBox('session');
      await Hive.openBox(HiveBoxes.settings);

      Get.put<AuthApi>(HiveAuthApi(), permanent: true);
      Get.put<AuthService>(AuthService(), permanent: true);
      final settings =
          Get.put<SettingsService>(SettingsService(), permanent: true);
      settings.onInit();
      await settings.completeOnboarding();
      await Hive.box(HiveBoxes.settings).put('language_selected', true);
      await Hive.box(HiveBoxes.settings).put('locale_code', 'en');
      settings.languageSelectedRx.value = true;
      settings.localeCodeRx.value = 'en';
      Get.put<AnalyticsService>(
        AnalyticsService(enabled: false),
        permanent: true,
      );
      Get.put<MessagingService>(
        MessagingService(enabled: false),
        permanent: true,
      );
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      Get.reset();
    });

    testWidgets('Login screen shows Register now and no demo credentials',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SttApp());

      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      expect(find.text('Register now'), findsOneWidget);
      expect(find.textContaining('Demo:'), findsNothing);
      expect(find.textContaining('driver@stt.com'), findsNothing);
      expect(find.textContaining('stt123'), findsNothing);

      await tester.tap(find.text('Register now'));
      await tester.pumpAndSettle();

      expect(appRouter.state.uri.path, AppRoutes.register);
    });

    testWidgets('Can navigate directly to login route',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SttApp());
      await tester.pumpAndSettle();

      AppNavigation.go(AppRoutes.login);
      await tester.pumpAndSettle();

      expect(find.text('Register now'), findsOneWidget);
      expect(find.textContaining('Demo:'), findsNothing);
    });
  });
}
