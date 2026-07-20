import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:stt_logistics_app/app.dart';
import 'package:stt_logistics_app/constants/app_strings.dart';
import 'package:stt_logistics_app/data/api/auth_api.dart';
import 'package:stt_logistics_app/data/local/hive_boxes.dart';
import 'package:stt_logistics_app/services/analytics_service.dart';
import 'package:stt_logistics_app/services/auth_service.dart';
import 'package:stt_logistics_app/services/messaging_service.dart';
import 'package:stt_logistics_app/services/settings_service.dart';

import 'helpers/fake_auth_api.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  late Directory tempDir;

  setUp(() async {
    Get.reset();
    tempDir = Directory.systemTemp.createTempSync('stt_widget_');
    Hive.init(tempDir.path);
    await Hive.openBox(HiveBoxes.settings);

    Get.put<AuthApi>(FakeAuthApi(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    final settings = Get.put<SettingsService>(SettingsService(), permanent: true);
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

  testWidgets('app boots to splash branding', (tester) async {
    await tester.pumpWidget(const SttApp());
    await tester.pump();

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.splashTagline), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump();
  });
}
