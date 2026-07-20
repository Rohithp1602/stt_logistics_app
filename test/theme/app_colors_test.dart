import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/constants/app_colors.dart';
import 'package:stt_logistics_app/constants/app_strings.dart';

void main() {
  test('soft industrial brand tokens match STT website-inspired palette', () {
    expect(AppColors.primary, const Color(0xFF06163A));
    expect(AppColors.accent, const Color(0xFFDE3232));
    expect(AppColors.accentDark, const Color(0xFFB62626));
    expect(AppColors.background, const Color(0xFFF7F7F8));
    expect(AppColors.surface, const Color(0xFFFFFFFF));
    expect(AppColors.textPrimary, const Color(0xFF0D0D0D));
    expect(AppColors.textSecondary, const Color(0xFF858FA6));
    expect(AppColors.border, const Color(0xFFE2E2E2));
    expect(AppColors.splashBackground, const Color(0xFF000000));
  });

  test('splash uses website marketing tagline', () {
    expect(AppStrings.splashTagline, "You Call, We Haul. That's All!");
  });
}
