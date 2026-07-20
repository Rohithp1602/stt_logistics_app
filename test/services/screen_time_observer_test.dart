import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/services/screen_time_observer.dart';

void main() {
  testWidgets('emits screen_time for named route on pop', (tester) async {
    final events = <Map<String, Object>>[];

    final observer = ScreenTimeObserver(
      onScreenTime: (name, ms) => events.add({'screen': name, 'ms': ms}),
      screenNameForRoute: (route) => route?.settings.name ?? 'unknown',
    );

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/a',
        navigatorObservers: [observer],
        onGenerateRoute: (settings) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () {
                  if (settings.name == '/a') {
                    Navigator.of(context).pushNamed('/b');
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(settings.name ?? ''),
              ),
            ),
          );
        },
      ),
    );

    await tester.tap(find.text('/a'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.text('/b'));
    await tester.pumpAndSettle();

    expect(events, isNotEmpty);
    expect(events.last['screen'], '/b');
    expect(events.last['ms'], greaterThanOrEqualTo(0));
  });
}
