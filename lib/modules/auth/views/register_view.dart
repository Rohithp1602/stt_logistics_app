import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../l10n/l10n.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../controllers/register_controller.dart';

/// Registration screen with form fields for user creation.
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterController get _controller => Get.find<RegisterController>();

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await _controller.register();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final strings = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo and title
                  Center(
                    child: Image.asset(
                      AppAssets.logo,
                      width: 72,
                      height: 72,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.local_shipping_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    strings.registerTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Profile photo (optional)
                  Center(
                    child: Obx(
                      () => GestureDetector(
                        onTap: controller.pickPhoto,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: AppColors.border,
                              width: 2,
                            ),
                          ),
                          child: controller.photoPath.value != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(48),
                                  child: Image.file(
                                    File(controller.photoPath.value!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: AppColors.textSecondary,
                                      size: 32,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Photo',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    strings.photoOptionalHint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Full name
                  AppTextField(
                    controller: controller.fullNameController,
                    label: strings.fullNameHint,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: controller.validateFullName,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  AppTextField(
                    controller: controller.emailController,
                    label: strings.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: controller.validateEmail,
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  AppTextField(
                    controller: controller.phoneController,
                    label: strings.phoneHint,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: controller.validatePhone,
                    prefixIcon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  Obx(
                    () => AppTextField(
                      controller: controller.passwordController,
                      label: strings.passwordHint,
                      obscureText: controller.obscurePassword.value,
                      textInputAction: TextInputAction.next,
                      validator: controller.validatePassword,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        onPressed: controller.togglePasswordVisibility,
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Confirm password
                  Obx(
                    () => AppTextField(
                      controller: controller.confirmPasswordController,
                      label: strings.confirmPasswordHint,
                      obscureText: controller.obscureConfirmPassword.value,
                      textInputAction: TextInputAction.next,
                      validator: controller.validateConfirmPassword,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        onPressed: controller.toggleConfirmPasswordVisibility,
                        icon: Icon(
                          controller.obscureConfirmPassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // CDL number
                  AppTextField(
                    controller: controller.cdlController,
                    label: strings.cdlHint,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: controller.validateCdl,
                    prefixIcon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 16),

                  // Hub / depot
                  AppTextField(
                    controller: controller.hubController,
                    label: strings.hubHint,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: controller.validateHub,
                    prefixIcon: Icons.location_on_outlined,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 24),

                  // Register button
                  Obx(
                    () => AppButton(
                      label: strings.registerButton,
                      isLoading: controller.isLoading.value,
                      onPressed: _submit,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sign in link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        strings.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () => Get.offNamed(AppRoutes.login),
                        child: Text(
                          strings.signInLink,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
