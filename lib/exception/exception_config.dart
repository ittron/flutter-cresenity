


class ExceptionConfig {
  bool enableLogger = true;
  ExceptionConfig._();
  static ExceptionConfig _instance = new ExceptionConfig._();

  factory ExceptionConfig.instance() {
    return _instance;
  }


}