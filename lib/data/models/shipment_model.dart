import '../../core/enums/shipment_status.dart';

/// Shipment record managed by the CRUD dashboard.
class ShipmentModel {
  const ShipmentModel({
    required this.id,
    required this.userId,
    required this.customerName,
    required this.origin,
    required this.destination,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String customerName;
  final String origin;
  final String destination;
  final ShipmentStatus status;
  final String createdAt;
  final String updatedAt;

  /// Creates a [ShipmentModel] from a JSON-like map.
  factory ShipmentModel.fromMap(Map<String, dynamic> map) {
    return ShipmentModel(
      id: map['id'] as String? ?? '',
      userId: map['user_id'] as String? ?? '',
      customerName: map['customer_name'] as String? ?? '',
      origin: map['origin'] as String? ?? '',
      destination: map['destination'] as String? ?? '',
      status: ShipmentStatusX.fromStorage(
        map['status'] as String? ?? 'pending',
      ),
      createdAt: map['created_at'] as String? ?? '',
      updatedAt: map['updated_at'] as String? ?? '',
    );
  }

  /// Serializes this shipment for local storage.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'customer_name': customerName,
      'origin': origin,
      'destination': destination,
      'status': status.storageValue,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Returns a copy with selective field overrides.
  ShipmentModel copyWith({
    String? id,
    String? userId,
    String? customerName,
    String? origin,
    String? destination,
    ShipmentStatus? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ShipmentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      customerName: customerName ?? this.customerName,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
