import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stt_logistics_app/widgets/responsive_page.dart';

void main() {
  testWidgets('breakpoints resolve for mobile tablet desktop', (tester) async {
    late AppBreakpoint mobileBp;
    late AppBreakpoint tabletBp;
    late AppBreakpoint desktopBp;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(390, 844)),
        child: Builder(
          builder: (context) {
            mobileBp = ResponsivePage.breakpointOf(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(mobileBp, AppBreakpoint.mobile);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(800, 1024)),
        child: Builder(
          builder: (context) {
            tabletBp = ResponsivePage.breakpointOf(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(tabletBp, AppBreakpoint.tablet);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(1440, 900)),
        child: Builder(
          builder: (context) {
            desktopBp = ResponsivePage.breakpointOf(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(desktopBp, AppBreakpoint.desktop);
  });

  testWidgets('AuthSplitScaffold uses split layout on wide screens',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: AuthSplitScaffold(
          child: Text('form-body'),
        ),
      ),
    );

    expect(find.text('STT Logistics'), findsOneWidget);
    expect(find.text('form-body'), findsOneWidget);
  });

  testWidgets('AuthSplitScaffold is single column on mobile', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: AuthSplitScaffold(
          child: Text('form-body'),
        ),
      ),
    );

    expect(find.text('form-body'), findsOneWidget);
    expect(find.text('STT Logistics'), findsNothing);
  });
}
