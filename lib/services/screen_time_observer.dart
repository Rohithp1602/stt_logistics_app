import 'package:flutter/widgets.dart';

/// Records dwell time between route pushes/pops/replacements.
class ScreenTimeObserver extends NavigatorObserver {
  ScreenTimeObserver({
    required this.onScreenTime,
    required this.screenNameForRoute,
  });

  final void Function(String screenName, int durationMs) onScreenTime;
  final String Function(Route<dynamic>? route) screenNameForRoute;

  final Map<Route<dynamic>, DateTime> _enteredAt = <Route<dynamic>, DateTime>{};

  void _enter(Route<dynamic>? route) {
    if (route == null) return;
    _enteredAt[route] = DateTime.now();
  }

  void _leave(Route<dynamic>? route) {
    if (route == null) return;
    final started = _enteredAt.remove(route);
    if (started == null) return;
    final ms = DateTime.now().difference(started).inMilliseconds;
    final name = screenNameForRoute(route);
    if (name == 'unknown' || name.isEmpty) return;
    onScreenTime(name, ms < 0 ? 0 : ms);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _leave(previousRoute);
    _enter(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _leave(route);
    _enter(previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _leave(oldRoute);
    _enter(newRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _leave(route);
  }
}
