



import 'dart:convert';

import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_cresenity/helper/arr.dart';
import 'package:flutter_cresenity/support/message_bag.dart';
import 'package:flutter_cresenity/support/tuple.dart';
import 'package:flutter_cresenity/support/collection.dart';
import 'package:flutter_cresenity/support/array.dart';
import 'package:flutter_cresenity/translation/translation_manager.dart';
import 'package:flutter_cresenity/validation/mixin/format_message.dart';
import 'package:flutter_cresenity/validation/mixin/validate_attribute.dart';
import 'package:flutter_cresenity/validation/validation_rule_parser.dart';
import 'package:flutter_cresenity/validation/validator_abstract.dart';




class Validator extends ValidatorAbstract with ValidateAttribute,FormatMessage {



  Collection initialRules;


  MessageBag _messages;

  Collection<Collection> _failedRules;
  Map _distinctValues;

  String dotPlaceholder;

  String _currentRule;



  Validator(Collection data, Collection rules, [Collection messages]) {
    if(messages==null) {
      messages = Collection();
    }
    this.customMessages = messages;
    this.data = data;
    this.initialRules = rules;
    this.dotPlaceholder = Str.random();
    this.fallbackMessages = Collection();

    this.translator = TranslationManager.instance().translator;
    setRules(rules);
  }


  Validator setRules(Collection rules) {
    rules = rules.map((key, value) => MapEntry(key.replaceAll(".",dotPlaceholder), value));

    this.initialRules = rules;

    this.rules = Collection<Array>();


    this.addRules(rules);
  }

  void addRules(Collection rules) {
    // The primary purpose of this parser is to expand any "*" rules to the all
    // of the explicit rules needed for the given data. For example the rule
    // names.* would get expanded to names.0, names.1, etc. for this data.
    rules = ValidationRuleParser(this.data).explode(rules);

    this.rules  = rules;


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

  Collection failed() {
    return this._failedRules;
  }

  bool passes() {
    this._messages = new MessageBag();
    this._distinctValues = {};
    this._failedRules = Collection();

    this.rules.forEach((attribute, rules) {
        rules.forEach((rule) {
          this._validateAttribute(attribute,rule);
        });
    });
  }

  _validateFunction() {
    return (rule,attribute, value, parameters) {

      switch(rule) {
        case 'Required':
          return this.validateRequired(attribute, value);
          break;
        case 'Email':
          return this.validateEmail(attribute, value,parameters);
          break;
        case 'Max':
          return this.validateMax(attribute, value,parameters);
          break;
      }
      return false;
    };

  }

  _validateAttribute(String attribute, rule) {
    this._currentRule = rule;

    List tuple = ValidationRuleParser.parse(rule);
    if(tuple[0]=='') {
      return;
    }
    rule = tuple[0];
    var parameters = tuple[1];
    var value = getValue(attribute);


    bool validatable = _isValidatable(rule, attribute, value);

    Function validateFunction = _validateFunction();


    if (validatable && ! validateFunction(rule,attribute, value, parameters)) {
      addFailure(attribute, rule, parameters);
    }

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

    attribute = Str.replace([this.dotPlaceholder, '__asterisk__'], ['.', '*'], attribute);
    
    
    this._messages.add(attribute, this.makeReplacements( this.getMessage(attribute, rule), attribute,rule,parameters));


    this.setFailedRule(attribute, rule, parameters);
  }


  setFailedRule(attribute,rule,parameters) {
    if(!this._failedRules.containsKey(attribute)) {
      this._failedRules[attribute] = Collection();
    }
    this._failedRules[attribute][rule] = parameters;
  }

}