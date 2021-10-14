import 'package:flutter_cresenity/exception/reporter/developer_dialog_reporter.dart';
import 'package:flutter_cresenity/exception/reporter/dialog_reporter.dart';
import 'package:flutter_cresenity/exception/reporter/page_reporter.dart';
import 'package:flutter_cresenity/exception/reporter/print_reporter.dart';
import 'package:flutter_cresenity/exception/reporter_abstract.dart';

class ExceptionConfig {
  bool enableLogger = true;
  bool enableDeviceParameter = true;
  bool enableApplicationParameter = true;
  bool enableRethrow = false;
  int handlerTimeout = 5000;

  final Map<String, dynamic> customParameters = {};
  ExceptionConfig._();
  static ExceptionConfig _instance = new ExceptionConfig._();

  List<ReporterAbstract> _reporters = [];

  List<ReporterAbstract> get reporters => _reporters;

  factory ExceptionConfig.instance() {
    return _instance;
  }

  ExceptionConfig addReporter(ReporterAbstract reporter) {
    this._reporters.add(reporter);
    return this;
  }

  ExceptionConfig addDialogReporter() {
    this._reporters.add(DialogReporter());
    return this;
  }

  ExceptionConfig addDeveloperDialogReporter() {
    this._reporters.add(DeveloperDialogReporter());
    return this;
  }

  ExceptionConfig addPageReporter() {
    this._reporters.add(PageReporter(showStackTrace: false));
    return this;
  }

  ExceptionConfig addPrintReporter() {
    this._reporters.add(PrintReporter());
    return this;
  }

  ExceptionConfig addDeveloperPageReporter() {
    this._reporters.add(PageReporter(showStackTrace: true));
    return this;
  }

  setRelease() {}

  setDevelopment() {}

  setProfile() {}
}
