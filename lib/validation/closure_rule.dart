


import 'package:flutter_cresenity/validation/rule_interface.dart';

class ClosureRule implements RuleInterface {

  Function callback;

  bool failed = false;


  String msg;

  ClosureRule(this.callback);

  bool passes(String attribute, value) {
    failed = false;
    this.callback(attribute,value,(message){
      this.failed = true;
      this.msg = message;
    });

    return !this.failed;
  }

  String message() {
    return msg;
  }
}