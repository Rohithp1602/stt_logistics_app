import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/constants/messaging_constants.dart';
import 'package:stt_logistics_app/routes/app_routes.dart';

void main() {
  group('parseMessagingRoute', () {
    test('defaults to shell for null/empty/unknown', () {
      expect(parseMessagingRoute(null), AppRoutes.shell);
      expect(parseMessagingRoute(''), AppRoutes.shell);
      expect(parseMessagingRoute('   '), AppRoutes.shell);
      expect(parseMessagingRoute('/login'), AppRoutes.shell);
      expect(parseMessagingRoute('/unknown'), AppRoutes.shell);
    });

    test('accepts allowed deep-link routes', () {
      expect(parseMessagingRoute(AppRoutes.shell), AppRoutes.shell);
      expect(parseMessagingRoute(AppRoutes.shipments), AppRoutes.shipments);
      expect(parseMessagingRoute(AppRoutes.driver), AppRoutes.driver);
      expect(
        parseMessagingRoute(AppRoutes.shipmentForm),
        AppRoutes.shipmentForm,
      );
    });
  });
}
