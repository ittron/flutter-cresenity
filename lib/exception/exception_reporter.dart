

import 'package:flutter/foundation.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/exception/exception_config.dart';
import 'package:flutter_cresenity/exception/exception_manager.dart';
import 'package:flutter_cresenity/exception/model/report.dart';
import 'package:flutter_cresenity/helper/utils.dart';

class ExceptionReporter {
  dynamic error;
  dynamic stackTrace;
  FlutterErrorDetails errorDetails;

  ExceptionReporter(this.error, this.stackTrace,{this.errorDetails});


  void report() {
      Report report = Report(
          error,
          stackTrace,
          DateTime.now(),
          ExceptionManager.instance().deviceParameter.data,
          ExceptionManager.instance().applicationParameter.data,
          ExceptionManager.instance().config.customParameters,
          errorDetails,
          Utils.getPlatformType());

      ExceptionConfig.instance().reporters.forEach((element) {
        element.requestAction(report, CF.navigator.navigatorKey.currentState?.overlay?.context);
      });

  }
}