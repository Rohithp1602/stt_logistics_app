import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/analytics_events.dart';
import '../../../core/errors/failures.dart';
import '../../../core/validators/form_validators.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../l10n/l10n.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_routes.dart';
import '../../../services/analytics_service.dart';
import '../../../services/performance_service.dart';
import '../../../utils/photo_storage.dart';
import '../../../utils/snackbar_helper.dart';

/// Handles registration form state and user creation flow.
class RegisterController extends GetxController {
  RegisterController({required this._repository});

  final AuthRepository _repository;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController cdlController = TextEditingController();
  final TextEditingController hubController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxnString photoPath = RxnString();

  final ImagePicker _picker = ImagePicker();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> pickPhoto() async {
    final strings = l10n;
    final source = await Get.bottomSheet<ImageSource>(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(strings.takePhoto),
                onTap: () => Get.back(result: ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(strings.chooseFromGallery),
                onTap: () => Get.back(result: ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
    );

    if (source == null) return;

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        photoPath.value = await PhotoStorage.saveFromXFile(image);
      }
    } catch (e) {
      SnackbarHelper.error('Failed to select photo: ${e.toString()}');
    }
  }

  Future<void> register() async {
    isLoading.value = true;

    final analytics = Get.isRegistered<AnalyticsService>()
        ? Get.find<AnalyticsService>()
        : null;
    final performance = Get.isRegistered<PerformanceService>()
        ? Get.find<PerformanceService>()
        : null;
    final trace = await performance?.startTrace(PerformanceTraces.registerSubmit);

    try {
      await _repository.register(
        email: emailController.text.trim(),
        password: passwordController.text,
        displayName: fullNameController.text.trim(),
        phone: phoneController.text.trim(),
        cdlNumber: cdlController.text.trim(),
        hub: hubController.text.trim(),
        photoPath: photoPath.value,
      );
      await performance?.stopTrace(trace);
      await analytics?.logEvent(AnalyticsEvents.flowRegisterSuccess);
      AppNavigation.go(AppRoutes.shell);
      SnackbarHelper.successAfterNav(l10n.registerSuccess);
    } on AuthFailure catch (failure) {
      await performance?.stopTrace(trace);
      await analytics?.logEvent(AnalyticsEvents.flowRegisterFail);
      if (failure.message.contains('email already exists') ||
          failure.message.contains('exists')) {
        SnackbarHelper.error(l10n.emailExists);
      } else {
        SnackbarHelper.error(failure.message);
      }
    } catch (e) {
      await performance?.stopTrace(trace);
      await analytics?.logEvent(AnalyticsEvents.flowRegisterFail);
      SnackbarHelper.error(l10n.registerFailed);
    } finally {
      isLoading.value = false;
    }
  }

  String? validateFullName(String? value) => FormValidators.required(value);

  String? validateEmail(String? value) => FormValidators.email(value);

  String? validatePhone(String? value) => FormValidators.phone(value);

  String? validatePassword(String? value) => FormValidators.password(value);

  String? validateConfirmPassword(String? value) =>
      FormValidators.confirmPassword(passwordController.text, value);

  String? validateCdl(String? value) => FormValidators.required(value);

  String? validateHub(String? value) => FormValidators.required(value);

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    cdlController.dispose();
    hubController.dispose();
    super.onClose();
  }
}
