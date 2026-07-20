import 'package:flutter/material.dart';

/// Centralized brand and semantic colors for STT Logistics.
///
/// Prefer these tokens over hard-coded [Color] values in widgets.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF06163A);
  static const Color primaryDark = Color(0xFF040E26);
  static const Color accent = Color(0xFFDE3232);
  static const Color accentDark = Color(0xFFB62626);

  /// Native + Flutter splash canvas (matches logo black background).
  static const Color splashBackground = Color(0xFF000000);

  static const Color background = Color(0xFFF7F7F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0D0D0D);
  static const Color textSecondary = Color(0xFF858FA6);
  static const Color border = Color(0xFFE2E2E2);

  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);

  /// Driver verification — STT Verified
  static const Color verified = Color(0xFF16A34A);

  /// Driver verification — awaiting review
  static const Color pending = Color(0xFFF59E0B);

  /// Driver verification — rejected
  static const Color rejected = Color(0xFFDC2626);
}
