import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../constants/messaging_constants.dart';
import '../data/local/hive_boxes.dart';
import '../routes/app_routes.dart';
import 'auth_service.dart';
import 'settings_service.dart';

/// Firebase Cloud Messaging facade for FG / BG / killed delivery.
///
/// **Android-only for now.** iOS push (APNs / capabilities) is deferred.
class MessagingService extends GetxService {
  MessagingService({bool enabled = true}) : _sdkEnabled = enabled;

  /// When false (tests), skips all Firebase / local-notification SDK work.
  final bool _sdkEnabled;

  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  bool _pushEnabled = true;
  String? _fcmToken;
  String? _pendingRoute;

  StreamSubscription<RemoteMessage>? _onMessageSub;
  StreamSubscription<RemoteMessage>? _onOpenedSub;
  StreamSubscription<String>? _onTokenSub;

  /// Latest FCM registration token (also persisted in Hive).
  String? get fcmToken => _fcmToken;

  /// Route deferred until the user is logged in / splash finishes.
  String? get pendingRoute => _pendingRoute;

  Box get _settingsBox => Hive.box(HiveBoxes.settings);

  bool get _isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<MessagingService> init() async {
    if (!_sdkEnabled) return this;
    if (!_isAndroid) {
      debugPrint('MessagingService: Android-only — skipping init');
      return this;
    }

    try {
      _pushEnabled = Get.isRegistered<SettingsService>()
          ? Get.find<SettingsService>().notificationsEnabled
          : true;

      await _initLocalNotifications();

      if (_pushEnabled) {
        await enable();
      }

      await _bindMessageHandlers();
      await _consumeInitialMessage();
    } catch (e, st) {
      debugPrint('MessagingService.init failed: $e\n$st');
    }
    return this;
  }

  /// Turns push on (permission + token). Called from Settings.
  Future<void> enable() async {
    if (!_sdkEnabled || !_isAndroid) return;
    _pushEnabled = true;
    try {
      await _requestAndroidPermissions();
      await _refreshToken();
      _listenTokenRefresh();
    } catch (e, st) {
      debugPrint('MessagingService.enable failed: $e\n$st');
    }
  }

  /// Turns push off (delete token, suppress FG banners).
  Future<void> disable() async {
    if (!_sdkEnabled || !_isAndroid) return;
    _pushEnabled = false;
    try {
      await FirebaseMessaging.instance.deleteToken();
      _fcmToken = null;
      await _settingsBox.delete(MessagingConstants.hiveKeyFcmToken);
    } catch (e, st) {
      debugPrint('MessagingService.disable failed: $e\n$st');
    }
  }

  /// Associates the current token with [userId] (or clears on null/empty).
  Future<void> bindUserId(String? userId) async {
    if (!_sdkEnabled) return;
    try {
      await _settingsBox.put(
        MessagingConstants.hiveKeyFcmTokenUserId,
        userId ?? '',
      );
    } catch (_) {}
  }

  /// Applies a deferred deep-link after splash / login when logged in.
  Future<void> handlePendingNavigation() async {
    final pending = _pendingRoute;
    if (pending == null) return;
    if (!_isLoggedIn) return;
    _pendingRoute = null;
    _navigateToRoute(pending);
  }

  Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings(
      MessagingConstants.androidStatusBarIcon,
    );
    const settings = InitializationSettings(android: android);

    await _local.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    final androidPlugin = _local.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        MessagingConstants.androidChannelId,
        MessagingConstants.androidChannelName,
        description: MessagingConstants.androidChannelDescription,
        importance: Importance.high,
      ),
    );
  }

  Future<void> _requestAndroidPermissions() async {
    final android = _local.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
  }

  Future<void> _refreshToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    await _persistToken(token);
  }

  void _listenTokenRefresh() {
    _onTokenSub?.cancel();
    _onTokenSub = FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      _persistToken(token);
    });
  }

  Future<void> _persistToken(String? token) async {
    _fcmToken = token;
    if (token == null || token.isEmpty) {
      await _settingsBox.delete(MessagingConstants.hiveKeyFcmToken);
      return;
    }
    await _settingsBox.put(MessagingConstants.hiveKeyFcmToken, token);
    debugPrint('FCM token: $token');
  }

  Future<void> _bindMessageHandlers() async {
    await _onMessageSub?.cancel();
    await _onOpenedSub?.cancel();

    _onMessageSub = FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    _onOpenedSub =
        FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);
  }

  Future<void> _consumeInitialMessage() async {
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) {
      _queueOrNavigate(initial);
    }
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    if (!_pushEnabled) return;
    try {
      final notification = message.notification;
      final title = notification?.title ?? 'STT Logistics';
      final body = notification?.body ?? '';
      final route = parseMessagingRoute(
        message.data[MessagingConstants.dataKeyRoute]?.toString(),
      );

      const androidDetails = AndroidNotificationDetails(
        MessagingConstants.androidChannelId,
        MessagingConstants.androidChannelName,
        channelDescription: MessagingConstants.androidChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
        // Status bar only — white truck silhouette.
        icon: MessagingConstants.androidStatusBarIcon,
        // Expanded shade — keep colorful app launcher (unchanged).
        largeIcon: DrawableResourceAndroidBitmap(
          MessagingConstants.androidLargeIcon,
        ),
      );
      const details = NotificationDetails(android: androidDetails);

      await _local.show(
        id: message.messageId?.hashCode ?? message.hashCode,
        title: title,
        body: body,
        notificationDetails: details,
        payload: route,
      );
    } catch (e, st) {
      debugPrint('MessagingService FG show failed: $e\n$st');
    }
  }

  void _onMessageOpened(RemoteMessage message) {
    _queueOrNavigate(message);
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    final route = parseMessagingRoute(response.payload);
    _navigateToRoute(route);
  }

  void _queueOrNavigate(RemoteMessage message) {
    final route = parseMessagingRoute(
      message.data[MessagingConstants.dataKeyRoute]?.toString(),
    );
    if (_isLoggedIn) {
      _navigateToRoute(route);
    } else {
      _pendingRoute = route;
    }
  }

  bool get _isLoggedIn =>
      Get.isRegistered<AuthService>() && Get.find<AuthService>().isLoggedIn;

  void _navigateToRoute(String route) {
    try {
      if (route == AppRoutes.shell) {
        Get.offAllNamed(AppRoutes.shell);
      } else {
        Get.toNamed(route);
      }
    } catch (e, st) {
      debugPrint('MessagingService navigate failed: $e\n$st');
    }
  }

  @override
  void onClose() {
    _onMessageSub?.cancel();
    _onOpenedSub?.cancel();
    _onTokenSub?.cancel();
    super.onClose();
  }
}
