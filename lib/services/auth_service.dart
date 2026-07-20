import 'package:get/get.dart';

import '../data/api/auth_api.dart';
import '../data/models/user_model.dart';
import 'analytics_service.dart';
import 'crashlytics_service.dart';
import 'messaging_service.dart';

/// In-memory session holder. Persistence is handled by [AuthApi].
class AuthService extends GetxService {
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  bool get isLoggedIn => currentUser.value != null;

  AuthApi get _api => Get.find<AuthApi>();

  Future<void> restoreSession() async {
    try {
      final user = await _api.restoreSession();
      if (user != null) {
        currentUser.value = user;
        if (Get.isRegistered<AnalyticsService>()) {
          await Get.find<AnalyticsService>().setUser(user.email);
        }
        if (Get.isRegistered<CrashlyticsService>()) {
          await Get.find<CrashlyticsService>().setUser(user.email);
        }
        if (Get.isRegistered<MessagingService>()) {
          await Get.find<MessagingService>().bindUserId(user.id);
        }
      }
    } catch (_) {
      currentUser.value = null;
    }
  }

  Future<void> setSession(UserModel user) async {
    currentUser.value = user;
    if (Get.isRegistered<AnalyticsService>()) {
      await Get.find<AnalyticsService>().setUser(user.email);
    }
    if (Get.isRegistered<CrashlyticsService>()) {
      await Get.find<CrashlyticsService>().setUser(user.email);
    }
    if (Get.isRegistered<MessagingService>()) {
      await Get.find<MessagingService>().bindUserId(user.id);
    }
  }

  Future<void> clearSession() async {
    currentUser.value = null;
    if (Get.isRegistered<AnalyticsService>()) {
      await Get.find<AnalyticsService>().clearUser();
    }
    if (Get.isRegistered<CrashlyticsService>()) {
      await Get.find<CrashlyticsService>().clearUser();
    }
    if (Get.isRegistered<MessagingService>()) {
      await Get.find<MessagingService>().bindUserId(null);
    }
  }
}
