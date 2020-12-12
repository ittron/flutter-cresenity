



import 'dart:convert';

import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_cresenity/support/message_bag.dart';
import 'package:flutter_cresenity/support/tuple.dart';
import 'package:flutter_cresenity/validation/validation_rule_parser.dart';

import '../helper/arr.dart';
import '../support/array.dart';
import '../support/collection.dart';
import '../support/collection.dart';
import '../support/collection.dart';
import '../support/collection.dart';

class Validator {

  Map customMessages;
  Map data;
  Map initialRules;
  Collection<Array> rules;

  MessageBag _messages;

  Map _failedRules;
  Map _distinctValues;

  String dotPlaceholder;

  String _currentRule;

  Validator(Map data, Map rules, [Map messages = const {}]) {
    this.customMessages = messages;
    this.data = data;
    this.initialRules = rules;
    this.dotPlaceholder = Str.random();

    setRules(rules);
  }


  Validator setRules(Map rules) {
    rules = rules.map((key, value) => MapEntry(key.replaceAll(".",dotPlaceholder), value));

    this.initialRules = rules;

    this.rules = Collection();


    this.addRules(rules);
  }

  void addRules(rules) {
    rules = Collection(rules);
    // The primary purpose of this parser is to expand any "*" rules to the all
    // of the explicit rules needed for the given data. For example the rule
    // names.* would get expanded to names.0, names.1, etc. for this data.
    Tuple response = (new ValidationRuleParser(this.data)).explode(rules);

    this.rules = Collection(response.item1);


  }


  MessageBag errors() {
    return this.messages();

  }

  ///Get the message container for the validator.
  MessageBag messages() {
    if(this._messages == null) {
      this.passes();
    }
    return this._messages;
  }

  Map failed() {
    return this._failedRules;
  }

  bool passes() {
    this._messages = new MessageBag();
    this._distinctValues = {};
    this._failedRules = {};

    this.rules.forEach((attribute, rules) {
        rules.forEach((rule) {
          this._validateAttribute(attribute,rule);
        });
    });
  }

  _validateFunction() {
    return (rule,attribute, value, parameters) {

      switch(rule) {
        case '':
          break;
      }
    };
  }

  _validateAttribute(String attribute, String rule) {
    this._currentRule = rule;
    Tuple tuple = ValidationRuleParser.parse(rule);
    if(tuple.item1=='') {
      return;
    }
    rule = tuple.item1;
    var parameters = tuple.item2;
    var value = _getValue(attribute);

    bool validatable = _isValidatable(rule, attribute, value);

    Function validateFunction = _validateFunction();


    if (validatable && ! validateFunction(rule,attribute, value, parameters)) {
      addFailure(attribute, rule, parameters);
    }

  }



  ///Get the value of a given attribute.
  _getValue(attribute)
  {
    return Arr.get(this.data, attribute);
  }

  ///Determine if the attribute is validatable.

  bool _isValidatable(rule, String attribute, value) {
    return true;
  }


  /// Add a failed rule and error message to the collection.

  addFailure(attribute, rule, [List parameters = const []]) {
    if (this.messages == null) {
      this.passes();
    }

    attribute = Str.replace([this,dotPlaceholder, '__asterisk__'], ['.', '*'], attribute);
    
    
    this._messages.add(attribute, 'error');


    this._failedRules[attribute][rule] = parameters;
  }




}