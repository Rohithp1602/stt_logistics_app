import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/widgets/trendy_bottom_nav.dart';

void main() {
  group('MainShellView - TrendyBottomNav', () {
    testWidgets('shows TrendyBottomNav with correct labels', (tester) async {
      // Arrange
      int currentIndex = 0;
      bool addPressed = false;

      // Act - Test the TrendyBottomNav directly to verify labels
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: TrendyBottomNav(
              currentIndex: currentIndex,
              onTap: (index) => currentIndex = index,
              onAdd: () => addPressed = true,
            ),
          ),
        ),
      );

      // Assert - Verify all bottom nav labels are present
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Shipments'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      
      // Verify the add button is present
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}