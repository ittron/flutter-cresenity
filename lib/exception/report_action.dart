

import 'package:flutter_cresenity/exception/model/report.dart';

abstract class ReportAction {
  ///Code which should be triggered if report mode has been confirmed
  void onActionConfirmed(Report report);

  /// Code which should be triggered if report mode has been rejected
  void onActionRejected(Report report);
}