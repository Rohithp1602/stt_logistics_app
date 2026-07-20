import '../routes/app_routes.dart';

/// FCM / local-notification constants and route parsing.
abstract class MessagingConstants {
  static const String androidChannelId = 'stt_default';
  static const String androidChannelName = 'STT Notifications';
  static const String androidChannelDescription =
      'Shipment and account alerts from STT Logistics';

  /// Status-bar small icon (white silhouette truck drawable).
  static const String androidStatusBarIcon = 'ic_stat_truck';

  /// Expanded-notification large icon (color app launcher).
  static const String androidLargeIcon = '@mipmap/ic_launcher';

  static const String hiveKeyFcmToken = 'fcm_token';
  static const String hiveKeyFcmTokenUserId = 'fcm_token_user_id';
  static const String dataKeyRoute = 'route';

  /// Routes allowed for push deep-links.
  static const Set<String> allowedRoutes = <String>{
    AppRoutes.shell,
    AppRoutes.shipments,
    AppRoutes.driver,
    AppRoutes.shipmentForm,
  };
}

/// Maps FCM data [route] to a named app route.
String parseMessagingRoute(String? raw) {
  if (raw == null || raw.trim().isEmpty) {
    return AppRoutes.shell;
  }
  final route = raw.trim();
  if (MessagingConstants.allowedRoutes.contains(route)) {
    return route;
  }
  return AppRoutes.shell;
}
