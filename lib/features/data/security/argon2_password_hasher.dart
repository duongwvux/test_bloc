import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:hashlib/hashlib.dart';

import 'password_hasher.dart';

class Argon2PasswordHasher implements PasswordHasher {
  const Argon2PasswordHasher();

  @override
  Future<String> hash(String password) => Isolate.run(() {
    final random = Random.secure();
    final salt = List<int>.generate(16, (_) => random.nextInt(256));
    return argon2id(
      utf8.encode(password),
      salt,
      hashLength: 32,
      security: const Argon2Security('app',  p: 1, t: 2, m: 19456,),
    ).encoded();
  });

  @override
  Future<bool> verify(String password, String encodedHash) => Isolate.run(() {
    if (!encodedHash.startsWith(r'$argon2id$')) return false;
    return argon2Verify(encodedHash, utf8.encode(password));
  });
}
