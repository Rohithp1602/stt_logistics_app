import 'package:stt_logistics_app/data/api/auth_api.dart';
import 'package:stt_logistics_app/data/models/user_model.dart';

/// Minimal [AuthApi] for widget tests — no Hive, no persisted session.
class FakeAuthApi implements AuthApi {
  @override
  Future<UserModel?> getCurrentUser() async => null;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {}

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? displayName,
    String? phone,
    String? cdlNumber,
    String? hub,
    String? photoPath,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> restoreSession() async => null;

  @override
  Future<UserModel> updateProfile({
    String? displayName,
    String? phone,
    String? cdlNumber,
    String? hub,
    String? photoPath,
  }) {
    throw UnimplementedError();
  }
}
