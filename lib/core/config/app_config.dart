class AppConfig {
  AppConfig._();

  static const bool useMock = false;

  static const String preprod = 'http://13.140.157.103/';
  static const String prod = 'http://13.140.157.103:3001/';

  static const String baseUrl = preprod;
}
