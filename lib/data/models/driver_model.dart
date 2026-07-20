import '../../core/enums/verification_status.dart';

/// Driver profile shown on the verification card.
class DriverModel {
  const DriverModel({
    this.userId = '',
    required this.name,
    this.phone = '',
    required this.cdlNumber,
    required this.hub,
    required this.status,
    this.photoPath,
  });

  final String userId;
  final String name;
  final String phone;
  final String cdlNumber;
  final String hub;
  final VerificationStatus status;
  final String? photoPath;

  /// Creates a [DriverModel] from a JSON-like map.
  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      userId: map['user_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      cdlNumber: map['cdl_number'] as String? ?? '',
      hub: map['hub'] as String? ?? '',
      status: VerificationStatus.values.firstWhere(
        (s) => s.name == (map['status'] as String? ?? 'pending'),
        orElse: () => VerificationStatus.pending,
      ),
      photoPath: map['photo_path'] as String?,
    );
  }

  /// Serializes this driver for local storage.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'name': name,
      'phone': phone,
      'cdl_number': cdlNumber,
      'hub': hub,
      'status': status.name,
      'photo_path': photoPath,
    };
  }

  /// Returns a copy with selective field overrides.
  DriverModel copyWith({
    String? userId,
    String? name,
    String? phone,
    String? cdlNumber,
    String? hub,
    VerificationStatus? status,
    String? photoPath,
  }) {
    return DriverModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      cdlNumber: cdlNumber ?? this.cdlNumber,
      hub: hub ?? this.hub,
      status: status ?? this.status,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}
