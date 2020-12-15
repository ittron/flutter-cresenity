




import 'package:flutter_cresenity/exception/exception_config.dart';

class ExceptionManager {
  static const String ADAPTER_HTTP = 'http';

  bool _enableLogger = true;
  bool _inited = false;
  ExceptionManager._();
  static final ExceptionManager _instance = new ExceptionManager._();

  factory ExceptionManager.instance() {
    return _instance;
  }

  ExceptionConfig get config => ExceptionConfig.instance();


  void init() {
    if(_inited) {

      _inited = true;
    }
  }


  void _initLogger() {
    if(config.enableLogger) {

    }
  }


}