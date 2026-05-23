class MockDelay {
  MockDelay._();

  static Future<void> wait([int milliseconds = 600]) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  }
}
