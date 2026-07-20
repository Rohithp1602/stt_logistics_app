import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../core/enums/verification_status.dart';
import '../../../core/validators/form_validators.dart';
import '../../../l10n/l10n.dart';
import '../../../utils/photo_storage.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/responsive_page.dart';
import '../controllers/profile_controller.dart';

/// Profile screen for editing user and driver information.
class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          strings.profile,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Obx(() => TextButton(
            onPressed: (controller.isSaving.value || controller.isLoading.value) 
                ? null 
                : () {
                    if (_formKey.currentState?.validate() == true) {
                      controller.saveProfile();
                    }
                  },
            child: controller.isSaving.value
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return ResponsivePage(
          maxWidth: 640,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              // Profile photo section
              Center(
                child: GestureDetector(
                  onTap: controller.onPhotoTap,
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.border,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: PhotoImage(
                            photoRef: controller.photoPath.value,
                            fit: BoxFit.cover,
                            placeholder: const Icon(
                              Icons.person,
                              size: 40,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  strings.changePhotoHint,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
              const SizedBox(height: 32),

              // Verification status
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      controller.driver.value?.status == VerificationStatus.verified
                          ? Icons.verified
                          : Icons.schedule,
                      color: controller.driver.value?.status == VerificationStatus.verified
                          ? AppColors.verified
                          : AppColors.pending,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.driverVerification,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          Text(
                            (controller.driver.value?.status ??
                                    VerificationStatus.pending)
                                .localizedLabel(strings),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: controller.driver.value?.status == VerificationStatus.verified
                                      ? AppColors.verified
                                      : controller.driver.value?.status == VerificationStatus.pending
                                          ? AppColors.pending
                                          : AppColors.rejected,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form fields
              Text(
                'Personal Information',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: controller.fullNameController,
                label: strings.fullNameHint,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: FormValidators.required,
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.border.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.emailHint,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          Text(
                            controller.user.value?.email ?? '',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.lock_outline,
                      color: AppColors.textSecondary,
                      size: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: controller.phoneController,
                label: strings.phoneHint,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: FormValidators.phone,
                prefixIcon: Icons.phone_outlined,
              ),
              const SizedBox(height: 24),

              Text(
                'Driver Information',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: controller.cdlController,
                label: strings.cdlHint,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.badge_outlined,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: controller.hubController,
                label: strings.hubHint,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 32),
              ],
            ),
          ),
          ),
        );
      }),
    );
  }
}
