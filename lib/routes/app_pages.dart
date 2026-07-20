import 'package:get/get.dart';

import '../constants/legal_copy.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/driver/bindings/driver_binding.dart';
import '../modules/driver/views/driver_verification_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/views/language_view.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/settings/views/legal_document_view.dart';
import '../modules/shipment/bindings/shipment_binding.dart';
import '../modules/shipment/views/shipment_form_view.dart';
import '../modules/shipment/views/shipment_list_view.dart';
import '../modules/shell/bindings/shell_binding.dart';
import '../modules/shell/views/main_shell_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import 'app_routes.dart';

/// GetX page registry — maps [AppRoutes] to views and bindings.
class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.language,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.shell,
      page: () => const MainShellView(),
      binding: ShellBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.driver,
      page: () => const DriverVerificationView(),
      binding: DriverBinding(),
    ),
    GetPage(
      name: AppRoutes.shipments,
      page: () => const ShipmentListView(),
      binding: ShipmentBinding(),
    ),
    GetPage(
      name: AppRoutes.shipmentForm,
      page: () => const ShipmentFormView(),
      // Use shell's ShipmentController — binding here would dispose it on pop.
    ),
    GetPage(
      name: AppRoutes.legalPrivacy,
      page: () => const LegalDocumentView(
        title: LegalCopy.privacyPolicyTitle,
        content: LegalCopy.privacyPolicyContent,
      ),
    ),
    GetPage(
      name: AppRoutes.legalTerms,
      page: () => const LegalDocumentView(
        title: LegalCopy.termsOfUseTitle,
        content: LegalCopy.termsOfUseContent,
      ),
    ),
  ];
}
