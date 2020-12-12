





import 'package:flutter_cresenity/validation/validator.dart';

class ValidationFactory {



  ValidationFactory._();
  static final ValidationFactory _instance = new ValidationFactory._();

  factory ValidationFactory.instance() {
    return _instance;
  }

  Validator make(Map data, Map rules, [Map messages = const {},]) {
    return new Validator(data, rules, messages);
  }





}