




import 'package:flutter/foundation.dart';
import 'package:flutter_cresenity/exception/exception_config.dart';
import 'package:flutter_cresenity/exception/exception_reporter.dart';
import 'package:flutter_cresenity/exception/model/report.dart';
import 'package:flutter_cresenity/exception/plugin/application_parameter.dart';
import 'package:flutter_cresenity/exception/plugin/device_parameter.dart';

class ExceptionManager {
  static const String ADAPTER_HTTP = 'http';

  Map<String, dynamic> _deviceParameters = Map();
  Map<String, dynamic> _applicationParameters = Map();

  bool _inited = false;
  ExceptionManager._();
  static final ExceptionManager _instance = new ExceptionManager._();

  factory ExceptionManager.instance() {
    return _instance;
  }

  ExceptionConfig get config => ExceptionConfig.instance();

  DeviceParameter deviceParameter = DeviceParameter();
  ApplicationParameter applicationParameter = ApplicationParameter();


  void init() {
    if(!_inited) {
      //_setupErrorHooks();
      _inited = true;
    }
  }


  void _initLogger() {
    if(config.enableLogger) {

    }
  }

  Future _setupErrorHooks() async {
    FlutterError.onError = (FlutterErrorDetails details) async {
      reportError(details.exception, details.stack, errorDetails: details);
    };

  }


  void reportError(dynamic error, dynamic stackTrace,{FlutterErrorDetails errorDetails}) async {
    ExceptionReporter(error, stackTrace, errorDetails: errorDetails).report();
  }


}