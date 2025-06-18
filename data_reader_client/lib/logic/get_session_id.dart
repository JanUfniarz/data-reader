import 'dart:math';

String getSessionID() => _IDGenerator.val;

class _IDGenerator {
  static const _lowercase = 'abcdefghijklmnopqrstuvwxyz';
  static const _uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _numbers = '0123456789';
  static const _symbols = '!@#\$%^&*()-_+=[]{}';
  static const _allChars = _lowercase + _uppercase + _numbers + _symbols;

  static String? _val;

  static String _generateRandomString(int length) => List.generate(
        length,
        (index) => _allChars[Random.secure().nextInt(_allChars.length)]
    ).join();

  static String get val {
    _val ??= _generateRandomString(20);
    return _val!;
  }
}