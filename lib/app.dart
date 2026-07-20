import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'l10n/app_locales.dart';
import 'l10n/app_localizations.dart';
import 'routes/app_router.dart';
import 'services/settings_service.dart';
import 'theme/app_theme.dart';

/// Root app for STT Logistics (GoRouter + GetX).
class SttApp extends StatefulWidget {
  const SttApp({super.key});

  @override
  State<SttApp> createState() => _SttAppState();
}

class _SttAppState extends State<SttApp> {
  Worker? _localeWorker;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<SettingsService>()) {
      _localeWorker = ever<String>(
        Get.find<SettingsService>().localeCodeRx,
        (code) {
          Get.locale = AppLocales.byStorageCode(code).locale;
          if (mounted) setState(() {});
        },
      );
    }
  }

  @override
  void dispose() {
    _localeWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Get.isRegistered<SettingsService>()
        ? Get.find<SettingsService>()
        : null;
    final locale = settings?.locale ?? Get.locale ?? const Locale('en');

    return GetMaterialApp.router(
      title: 'STT Logistics',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      locale: locale,
      fallbackLocale: const Locale('en'),
      supportedLocales: AppLocales.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      backButtonDispatcher: appRouter.backButtonDispatcher,
    );
  }
}
