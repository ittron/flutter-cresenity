import 'package:flutter/material.dart';
import 'package:flutter_cresenity/exception/model/report.dart';
import 'package:flutter_cresenity/exception/reporter_abstract.dart';

class PrintReporter extends ReporterAbstract {
  @override
  void requestAction(Report report, BuildContext context) {
    print('Error happened:');
    print(report.error);
    print('Stack Trace:');
    print(report.stackTrace);
  }
}
