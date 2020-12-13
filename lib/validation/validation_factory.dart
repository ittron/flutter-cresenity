





import 'package:flutter_cresenity/validation/validator.dart';
import 'package:flutter_cresenity/support/collection.dart';



class ValidationFactory {



  ValidationFactory._();
  static final ValidationFactory _instance = new ValidationFactory._();

  factory ValidationFactory.instance() {
    return _instance;
  }

  Validator make(data, rules, [messages]) {
    return new Validator(Collection(data), Collection(rules), Collection(messages));
  }





}