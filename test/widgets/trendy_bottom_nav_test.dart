import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/widgets/trendy_bottom_nav.dart';

void main() {
  group('TrendyBottomNav', () {
    testWidgets('contains all 4 labels and add icon', (tester) async {
      int tappedIndex = -1;
      bool addPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TrendyBottomNav(
              currentIndex: 0,
              onTap: (index) => tappedIndex = index,
              onAdd: () => addPressed = true,
            ),
          ),
        ),
      );

      // Verify all 4 labels are present
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Shipments'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);

      // Verify add icon is present
      expect(find.byIcon(Icons.add), findsOneWidget);

      // Test tapping functionality
      await tester.tap(find.text('Profile'));
      expect(tappedIndex, equals(2));

      await tester.tap(find.byIcon(Icons.add));
      expect(addPressed, isTrue);
    });
  });
}