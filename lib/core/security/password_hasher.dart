import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class PasswordHash {
  const PasswordHash({required this.salt, required this.hash});
  final String salt;
  final String hash;
}

class PasswordHasher {
  PasswordHasher._();

  static PasswordHash hash(String password) {
    final salt = _randomSalt();
    return PasswordHash(salt: salt, hash: _digest(password, salt));
  }

  static bool verify(String password, String salt, String hash) {
    return _digest(password, salt) == hash;
  }

  static String _digest(String password, String salt) {
    return sha256.convert(utf8.encode('$salt::$password')).toString();
  }

  static String _randomSalt([int length = 16]) {
    final rand = Random.secure();
    final bytes = List<int>.generate(length, (_) => rand.nextInt(256));
    return base64UrlEncode(bytes);
  }
}
