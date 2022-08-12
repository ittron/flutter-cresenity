import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/exception/model/report.dart';
import 'package:flutter_cresenity/exception/reporter_abstract.dart';
import 'package:flutter_cresenity/helper/utils.dart';

class PageReporter extends ReporterAbstract {
  final bool showStackTrace;

  PageReporter({
    this.showStackTrace = true,
  }) : assert(showStackTrace != null, "showStackTrace can't be null");

  @override
  void requestAction(Report report, BuildContext context) {
    _navigateToPageWidget(report, context);
  }

  void _navigateToPageWidget(Report report, BuildContext context) async {
    await Future.delayed(Duration.zero);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageWidget(this, report),
      ),
    );
  }

  @override
  bool isContextRequired() {
    return true;
  }
}

class PageWidget extends StatefulWidget {
  final PageReporter pageReporter;
  final Report report;

  PageWidget(this.pageReporter, this.report);

  @override
  PageWidgetState createState() {
    return new PageWidgetState();
  }
}

class PageWidgetState extends State<PageWidget> {
  @override
  Widget build(BuildContext context) {
    return Utils.isCupertinoAppAncestor(context)
        ? _buildCupertinoPage()
        : _buildMaterialPage();
  }

  Widget _buildMaterialPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(CF.translator.get('exception.page_title')),
      ),
      body: _buildInnerWidget(),
    );
  }

  Widget _buildCupertinoPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(CF.translator.get('exception.page_title')),
      ),
      child: SafeArea(
        child: _buildInnerWidget(),
      ),
    );
  }

  Widget _buildInnerWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              CF.translator.get('exception.page_description'),
              style: _getTextStyle(15),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.report.error.toString(),
              style: _getTextStyle(15),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _getStackTraceWidget(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text(CF.translator.get('exception.accept')),
                onPressed: () => _onAcceptClicked(),
              ),
              TextButton(
                child: Text(CF.translator.get('exception.cancel')),
                onPressed: () => _onCancelClicked(),
              ),
            ],
          )
        ],
      ),
    );
  }

  TextStyle _getTextStyle(double fontSize) {
    return TextStyle(
        fontSize: fontSize,
        color: Colors.black,
        decoration: TextDecoration.none);
  }

  Widget _getStackTraceWidget() {
    if (widget.pageReporter.showStackTrace) {
      var items = widget.report.stackTrace.toString().split("\n");
      return SizedBox(
        height: 300.0,
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(
              '${items[index]}',
              style: _getTextStyle(10),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  void _onAcceptClicked() {
    widget.pageReporter.onActionConfirmed(widget.report);
    _closePage();
  }

  void _onCancelClicked() {
    widget.pageReporter.onActionRejected(widget.report);
    _closePage();
  }

  void _closePage() {
    Navigator.of(context).pop();
  }
}
