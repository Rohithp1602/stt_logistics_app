import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'app_localizations.dart';

/// Resolve [AppLocalizations] from GetX context, or English fallback in tests.
AppLocalizations get l10n {
  try {
    final context = Get.context;
    if (context != null) {
      return AppLocalizations.of(context);
    }
  } catch (_) {
    // WidgetsBinding may be uninitialized in pure unit tests.
  }
  final locale = Get.locale ?? const Locale('en');
  return lookupAppLocalizations(locale);
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
