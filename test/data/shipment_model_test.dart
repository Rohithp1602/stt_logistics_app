import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/core/enums/shipment_status.dart';
import 'package:stt_logistics_app/data/models/shipment_model.dart';

void main() {
  test('fromMap/toMap round-trip includes userId and timestamps', () {
    final model = ShipmentModel(
      id: 'SHP-abc',
      userId: 'user-1',
      customerName: 'Acme',
      origin: 'Dallas, TX',
      destination: 'Houston, TX',
      status: ShipmentStatus.pending,
      createdAt: '2026-07-21T10:00:00.000Z',
      updatedAt: '2026-07-21T11:00:00.000Z',
    );

    final again = ShipmentModel.fromMap(model.toMap());

    expect(again.userId, 'user-1');
    expect(again.createdAt, '2026-07-21T10:00:00.000Z');
    expect(again.updatedAt, '2026-07-21T11:00:00.000Z');
    expect(again.toMap()['user_id'], 'user-1');
  });
}
