import 'package:flutter_cresenity/exception/reporter/developer_dialog_reporter.dart';
import 'package:flutter_cresenity/exception/reporter/dialog_reporter.dart';
import 'package:flutter_cresenity/exception/reporter/page_reporter.dart';
import 'package:flutter_cresenity/exception/reporter_abstract.dart';

class ExceptionConfig {
  bool enableLogger = true;
  bool enableDeviceParameter = true;
  bool enableApplicationParameter = true;
  int handlerTimeout = 5000;

  final Map<String, dynamic> customParameters = {};
  ExceptionConfig._();
  static ExceptionConfig _instance = new ExceptionConfig._();

  List<ReporterAbstract> _reporters = [];

  List<ReporterAbstract> get reporters => _reporters;

  factory ExceptionConfig.instance() {
    return _instance;
  }

  addReporter(ReporterAbstract reporter) {
    this._reporters.add(reporter);
  }

  addDialogReporter() {
    this._reporters.add(DialogReporter());
  }

  addDeveloperDialogReporter() {
    this._reporters.add(DeveloperDialogReporter());
  }

  addPageReporter() {
    this._reporters.add(PageReporter(showStackTrace: false));
  }

  addDeveloperPageReporter() {
    this._reporters.add(PageReporter(showStackTrace: true));
  }

  setRelease() {}

  setDevelopment() {}

  setProfile() {}
}
