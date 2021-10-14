


import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/exception/exception_manager.dart';
import 'package:flutter_cresenity/interface/bootable.dart';

class ExceptionBootstrap implements Bootable {
  @override
  Future<void> boot() async {

    _loadLanguage();
    List<Bootable> bootable = [];
    bootable.add(ExceptionManager.instance().deviceParameter);
    bootable.add(ExceptionManager.instance().applicationParameter);


    for(int i=0; i<bootable.length;i++) {
      await bootable[i].boot();
    }
    ExceptionManager.instance().init();

  }


  _loadLanguage() {
    CF.translation.loadRepository("en_US", {
      'exception': {
        'notification_title': 'Application error occurred',
        'notification_content': 'Click here to send error report to support team.',
        'dialog_title': 'Crash',
        'dialog_description': 'Unexpected error occurred in application. Error report is ready to send to support team. Please click Accept to send error report or Cancel to dismiss report.',
        'page_title': 'Application error occurred',
        'page_description': 'Unexpected error occurred in application. Error report is ready to send to support team. Please click Accept to send error report or Cancel to dismiss report.',
        'accept': 'Accept',
        'cancel': 'Cancel',
      }
    });
  }
}