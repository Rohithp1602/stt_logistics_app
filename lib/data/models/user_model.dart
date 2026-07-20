/// Authenticated user identity used across the session.
class UserModel {
  UserModel({
    this.id = '',
    required this.email,
    this.passwordHash = '',
    this.passwordSalt = '',
    this.displayName,
    this.phone = '',
    this.photoPath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  final String id;
  final String email;
  final String passwordHash;
  final String passwordSalt;
  final String? displayName;
  final String phone;
  final String? photoPath;
  final DateTime createdAt;

  /// Creates a [UserModel] from a JSON-like map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? '',
      email: map['email'] as String? ?? '',
      passwordHash: map['password_hash'] as String? ?? '',
      passwordSalt: map['password_salt'] as String? ?? '',
      displayName: map['display_name'] as String?,
      phone: map['phone'] as String? ?? '',
      photoPath: map['photo_path'] as String?,
      createdAt: _parseCreatedAt(map['created_at']),
    );
  }

  /// Serializes this user for local storage.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password_hash': passwordHash,
      'password_salt': passwordSalt,
      'display_name': displayName,
      'phone': phone,
      'photo_path': photoPath,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Returns a copy with selective field overrides.
  UserModel copyWith({
    String? id,
    String? email,
    String? passwordHash,
    String? passwordSalt,
    String? displayName,
    String? phone,
    String? photoPath,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      displayName: displayName ?? this.displayName,
      phone: phone ?? this.phone,
      photoPath: photoPath ?? this.photoPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static DateTime _parseCreatedAt(Object? raw) {
    if (raw == null) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    if (raw is DateTime) {
      return raw;
    }
    if (raw is String && raw.isNotEmpty) {
      return DateTime.tryParse(raw) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    if (raw is int) {
      return DateTime.fromMillisecondsSinceEpoch(raw);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}
