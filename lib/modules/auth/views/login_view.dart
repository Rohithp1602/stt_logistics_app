import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../l10n/l10n.dart';
import '../../../routes/app_router.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/responsive_page.dart';
import '../controllers/login_controller.dart';

/// Email / password login screen with client-side validation.
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginController get _controller => Get.find<LoginController>();

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await _controller.login();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final strings = context.l10n;
    final compact = ResponsivePage.isCompact(context);

    final form = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (compact) ...[
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
              strings.loginTitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            Text(
              strings.welcomeBack,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              strings.loginTitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          const SizedBox(height: 32),
          AppTextField(
            controller: controller.emailController,
            label: strings.emailHint,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: controller.validateEmail,
            prefixIcon: Icons.email_outlined,
          ),
          const SizedBox(height: 16),
          Obx(
            () => AppTextField(
              controller: controller.passwordController,
              label: strings.passwordHint,
              obscureText: controller.obscurePassword.value,
              textInputAction: TextInputAction.done,
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
              onFieldSubmitted: (_) => _submit(),
            ),
          ),
          const SizedBox(height: 24),
          Obx(
            () => AppButton(
              label: strings.loginButton,
              isLoading: controller.isLoading.value,
              onPressed: _submit,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                strings.dontHaveAccount,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: () => AppNavigation.go(AppRoutes.register),
                child: Text(
                  strings.registerNow,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (compact) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: form,
              ),
            ),
          ),
        ),
      );
    }

    return AuthSplitScaffold(
      child: SingleChildScrollView(child: form),
    );
  }
}
