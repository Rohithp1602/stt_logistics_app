import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:stt_logistics_app/data/api/auth_api.dart';
import 'package:stt_logistics_app/data/local/hive_boxes.dart';
import 'package:stt_logistics_app/l10n/app_localizations.dart';
import 'package:stt_logistics_app/modules/language/views/language_view.dart';
import 'package:stt_logistics_app/services/auth_service.dart';
import 'package:stt_logistics_app/services/settings_service.dart';

import 'helpers/fake_auth_api.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    Get.reset();
    tempDir = Directory.systemTemp.createTempSync('stt_lang_ui_');
    Hive.init(tempDir.path);
    await Hive.openBox(HiveBoxes.settings);
    Get.put<AuthApi>(FakeAuthApi(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put(SettingsService(), permanent: true).onInit();
    Get.put(LanguageController());
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    Get.reset();
  });

  testWidgets('language view builds and lists English', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      GetMaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LanguageView(),
      ),
    );
    await tester.pump();

    expect(find.text('Choose your language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
