import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/exception/model/report.dart';
import 'package:flutter_cresenity/exception/reporter_abstract.dart';
import 'package:flutter_cresenity/helper/utils.dart';

class DialogReporter extends ReporterAbstract {
  @override
  void requestAction(Report report, BuildContext context) {
    _showDialog(report, context);
  }

  Future _showDialog(Report report, BuildContext context) async {
    await Future.delayed(Duration.zero);
    if (Utils.isCupertinoAppAncestor(context)) {
      return showCupertinoDialog(
          context: context,
          builder: (context) => _buildCupertinoDialog(report, context));
    } else {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _buildMaterialDialog(report, context));
    }
  }

  Widget _buildCupertinoDialog(Report report, BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(CF.translator.get('exception.dialog_title')),
      content: Text(CF.translator.get('exception.dialog_description')),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(CF.translator.get('exception.accept')),
          onPressed: () => _onAcceptReportClicked(context, report),
        ),
        CupertinoDialogAction(
          child: Text(CF.translator.get('exception.cancel')),
          onPressed: () => _onCancelReportClicked(context, report),
        ),
      ],
    );
  }

  Widget _buildMaterialDialog(Report report, BuildContext context) {
    return AlertDialog(
      title: Text(CF.translator.get('exception.dialog_title')),
      content: Text(CF.translator.get('exception.dialog_description')),
      actions: <Widget>[
        TextButton(
          child: Text(CF.translator.get('exception.accept')),
          onPressed: () => _onAcceptReportClicked(context, report),
        ),
        TextButton(
          child: Text(CF.translator.get('exception.cancel')),
          onPressed: () => _onCancelReportClicked(context, report),
        ),
      ],
    );
  }

  void _onAcceptReportClicked(BuildContext context, Report report) {
    super.onActionConfirmed(report);
    Navigator.pop(context);
  }

  void _onCancelReportClicked(BuildContext context, Report report) {
    super.onActionRejected(report);
    Navigator.pop(context);
  }
}
