import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'l10n/app_locales.dart';
import 'l10n/app_localizations.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/analytics_service.dart';
import 'services/settings_service.dart';
import 'theme/app_theme.dart';

/// Root [GetMaterialApp] for STT Logistics.
class SttApp extends StatelessWidget {
  const SttApp({super.key});

  @override
  Widget build(BuildContext context) {
    final observers = Get.isRegistered<AnalyticsService>()
        ? Get.find<AnalyticsService>().navigatorObservers
        : <NavigatorObserver>[];
    final settings = Get.isRegistered<SettingsService>()
        ? Get.find<SettingsService>()
        : null;

    return GetMaterialApp(
      title: 'STT Logistics',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      // Initial locale from Hive; runtime changes use Get.updateLocale.
      locale: settings?.locale ?? const Locale('en'),
      fallbackLocale: const Locale('en'),
      supportedLocales: AppLocales.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
      navigatorObservers: observers,
    );
  }
}
