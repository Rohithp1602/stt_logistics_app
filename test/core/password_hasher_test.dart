import 'package:flutter_test/flutter_test.dart';
import 'package:stt_logistics_app/core/security/password_hasher.dart';

void main() {
  test('hash then verify succeeds; wrong password fails', () {
    final result = PasswordHasher.hash('stt123');
    expect(PasswordHasher.verify('stt123', result.salt, result.hash), isTrue);
    expect(PasswordHasher.verify('wrong', result.salt, result.hash), isFalse);
  });
}
