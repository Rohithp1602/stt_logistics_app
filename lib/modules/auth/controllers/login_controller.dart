import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/analytics_events.dart';
import '../../../core/errors/failures.dart';
import '../../../core/validators/form_validators.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../l10n/l10n.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_routes.dart';
import '../../../services/analytics_service.dart';
import '../../../services/messaging_service.dart';
import '../../../services/performance_service.dart';
import '../../../utils/snackbar_helper.dart';

/// Handles login form state and authentication flow.
class LoginController extends GetxController {
  LoginController({required this._repository});

  final AuthRepository _repository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;

  /// Toggles password field visibility.
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// Attempts authentication. Caller must validate the form first.
  Future<void> login() async {
    isLoading.value = true;

    final analytics = Get.isRegistered<AnalyticsService>()
        ? Get.find<AnalyticsService>()
        : null;
    final performance = Get.isRegistered<PerformanceService>()
        ? Get.find<PerformanceService>()
        : null;
    final trace = await performance?.startTrace(PerformanceTraces.loginSubmit);

    try {
      await _repository.login(
        email: emailController.text,
        password: passwordController.text,
      );
      await performance?.stopTrace(trace);
      await analytics?.logEvent(AnalyticsEvents.flowLoginSuccess);
      AppNavigation.go(AppRoutes.shell);
      SnackbarHelper.successAfterNav(l10n.loginSuccess);
      if (Get.isRegistered<MessagingService>()) {
        await Get.find<MessagingService>().handlePendingNavigation();
      }
    } on AuthFailure {
      await performance?.stopTrace(trace);
      await analytics?.logEvent(AnalyticsEvents.flowLoginFail);
      SnackbarHelper.error(l10n.loginFailed);
    } catch (_) {
      await performance?.stopTrace(trace);
      await analytics?.logEvent(AnalyticsEvents.flowLoginFail);
      SnackbarHelper.error(l10n.loginFailed);
    } finally {
      isLoading.value = false;
    }
  }

  /// Email field validator wired to [FormValidators.email].
  String? validateEmail(String? value) => FormValidators.email(value);

  /// Password field validator wired to [FormValidators.password].
  String? validatePassword(String? value) => FormValidators.password(value);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
