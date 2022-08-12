import 'package:flutter/cupertino.dart';
import 'package:flutter_cresenity/exception/model/report.dart';
import 'package:flutter_cresenity/exception/report_action.dart';

abstract class ReporterAbstract {
  ReportAction? _reportAction;

  /// Set report mode action.
  void setReportModeAction(ReportAction reportAction) {
    this._reportAction = reportAction;
  }

  /// Code which should be triggered if new error has been catched and core
  /// creates report about this.
  void requestAction(Report report, BuildContext context);

  /// On user has accepted report
  void onActionConfirmed(Report report) {
    if (_reportAction != null) {
      _reportAction!.onActionConfirmed(report);
    }
  }

  /// On user has rejected report
  void onActionRejected(Report report) {
    if (_reportAction != null) {
      _reportAction!.onActionRejected(report);
    }
  }

  /// Check if given report mode requires context to run
  bool isContextRequired() {
    return false;
  }
}
