import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

/// Thin wrapper around GetX snackbars for consistent feedback messaging.
class SnackbarHelper {
  SnackbarHelper._();

  static const Duration _successDuration = Duration(milliseconds: 2500);
  static const Duration _errorDuration = Duration(milliseconds: 3500);

  /// Shows a green success snackbar on the current route.
  static void success(String message, {String title = 'Success'}) {
    _show(
      title: title,
      message: message,
      background: AppColors.success,
      icon: Icons.check_circle_rounded,
      duration: _successDuration,
    );
  }

  /// Shows a red error snackbar on the current route.
  static void error(String message, {String title = 'Error'}) {
    _show(
      title: title,
      message: message,
      background: AppColors.error,
      icon: Icons.error_rounded,
      duration: _errorDuration,
    );
  }

  /// Shows a neutral informational snackbar on the current route.
  static void info(String message, {String title = 'Info'}) {
    _show(
      title: title,
      message: message,
      background: AppColors.info,
      icon: Icons.info_rounded,
      duration: _successDuration,
    );
  }

  /// Success toast after a route replace (e.g. login → home).
  static void successAfterNav(String message, {String title = 'Success'}) {
    _afterNav(() => success(message, title: title));
  }

  /// Error toast after navigation.
  static void errorAfterNav(String message, {String title = 'Error'}) {
    _afterNav(() => error(message, title: title));
  }

  /// Info toast after a route replace (e.g. logout → login).
  static void infoAfterNav(String message, {String title = 'Info'}) {
    _afterNav(() => info(message, title: title));
  }

  static void _afterNav(VoidCallback show) {
    Future.microtask(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // One more frame so GetX finishes swapping the overlay after offAllNamed.
        WidgetsBinding.instance.addPostFrameCallback((_) => show());
      });
    });
  }

  static void _show({
    required String title,
    required String message,
    required Color background,
    required IconData icon,
    required Duration duration,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: background.withValues(alpha: 0.95),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 14,
      duration: duration,
      icon: Icon(icon, color: Colors.white),
      shouldIconPulse: false,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
