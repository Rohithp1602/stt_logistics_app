import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Reusable [BoxDecoration] and spacing helpers for consistent surfaces.
class AppDecorations {
  AppDecorations._();

  /// Soft elevated card surface used on dashboards.
  static BoxDecoration get card => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static const EdgeInsets pagePadding = EdgeInsets.all(16);
  static const EdgeInsets sectionGap = EdgeInsets.symmetric(vertical: 12);
}
