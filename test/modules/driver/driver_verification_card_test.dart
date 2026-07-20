import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/core/enums/verification_status.dart';
import 'package:stt_logistics_app/data/models/driver_model.dart';
import 'package:stt_logistics_app/l10n/app_localizations.dart';
import 'package:stt_logistics_app/modules/driver/widgets/driver_verification_card.dart';

void main() {
  const driver = DriverModel(
    userId: 'user-1',
    name: 'Alex Driver',
    phone: '+1 555 0100',
    cdlNumber: 'CDL-9988',
    hub: 'Chicago Hub',
    status: VerificationStatus.verified,
  );

  testWidgets('driver card stays within max width on wide layout',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ListView(
            children: [
              DriverVerificationCard(driver: driver, compact: true),
            ],
          ),
        ),
      ),
    );

    final cardSize = tester.getSize(find.byType(AspectRatio));
    expect(cardSize.width, lessThanOrEqualTo(kDriverLicenseCardMaxWidth + 0.5));
    expect(cardSize.width, lessThan(600));
  });

  testWidgets('driver card uses available width on narrow layout',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              DriverVerificationCard(driver: driver, compact: true),
            ],
          ),
        ),
      ),
    );

    final cardSize = tester.getSize(find.byType(AspectRatio));
    // 360 viewport - 32 padding ≈ 328
    expect(cardSize.width, lessThanOrEqualTo(360));
    expect(cardSize.width, greaterThan(280));
  });

  testWidgets('driver card stays within max width on tablet layout',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(834, 1112));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              DriverVerificationCard(driver: driver, compact: true),
              const SizedBox(height: 16),
              DriverLicenseBackCard(driver: driver),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(AspectRatio), findsNWidgets(2));
    for (final element in find.byType(AspectRatio).evaluate()) {
      expect(
        element.size!.width,
        lessThanOrEqualTo(kDriverLicenseCardMaxWidth + 0.5),
      );
    }
  });
}
