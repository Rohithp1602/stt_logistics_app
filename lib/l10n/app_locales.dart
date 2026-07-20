import 'package:flutter/material.dart';

/// Supported app locales and native display labels.
class AppLocaleOption {
  const AppLocaleOption({
    required this.languageCode,
    this.countryCode,
    required this.nativeName,
    required this.englishName,
  });

  final String languageCode;
  final String? countryCode;
  final String nativeName;
  final String englishName;

  Locale get locale =>
      countryCode == null ? Locale(languageCode) : Locale(languageCode, countryCode);

  String get storageCode =>
      countryCode == null ? languageCode : '${languageCode}_$countryCode';
}

class AppLocales {
  AppLocales._();

  static const List<AppLocaleOption> all = [
    AppLocaleOption(
      languageCode: 'en',
      nativeName: 'English',
      englishName: 'English (US)',
    ),
    AppLocaleOption(
      languageCode: 'es',
      nativeName: 'Español',
      englishName: 'Spanish',
    ),
    AppLocaleOption(
      languageCode: 'es',
      countryCode: 'MX',
      nativeName: 'Español (México)',
      englishName: 'Mexican Spanish',
    ),
    AppLocaleOption(
      languageCode: 'de',
      nativeName: 'Deutsch',
      englishName: 'German',
    ),
    AppLocaleOption(
      languageCode: 'hi',
      nativeName: 'हिन्दी',
      englishName: 'Hindi',
    ),
    AppLocaleOption(
      languageCode: 'gu',
      nativeName: 'ગુજરાતી',
      englishName: 'Gujarati',
    ),
    AppLocaleOption(
      languageCode: 'ja',
      nativeName: '日本語',
      englishName: 'Japanese',
    ),
    AppLocaleOption(
      languageCode: 'fr',
      nativeName: 'Français',
      englishName: 'French',
    ),
    AppLocaleOption(
      languageCode: 'zh',
      nativeName: '中文',
      englishName: 'Chinese',
    ),
    AppLocaleOption(
      languageCode: 'ko',
      nativeName: '한국어',
      englishName: 'Korean',
    ),
    AppLocaleOption(
      languageCode: 'vi',
      nativeName: 'Tiếng Việt',
      englishName: 'Vietnamese',
    ),
    AppLocaleOption(
      languageCode: 'pt',
      nativeName: 'Português',
      englishName: 'Portuguese',
    ),
    AppLocaleOption(
      languageCode: 'it',
      nativeName: 'Italiano',
      englishName: 'Italian',
    ),
    AppLocaleOption(
      languageCode: 'ar',
      nativeName: 'العربية',
      englishName: 'Arabic',
    ),
    AppLocaleOption(
      languageCode: 'fil',
      nativeName: 'Filipino',
      englishName: 'Filipino',
    ),
  ];

  static AppLocaleOption byStorageCode(String code) {
    return all.firstWhere(
      (o) => o.storageCode == code,
      orElse: () => all.first,
    );
  }

  static List<Locale> get supportedLocales =>
      all.map((o) => o.locale).toList(growable: false);
}
