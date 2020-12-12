



import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_cresenity/support/tuple.dart';
import 'package:flutter_cresenity/validation/closure_rule.dart';
import 'package:flutter_cresenity/validation/rule_interface.dart';

import '../helper/arr.dart';
import '../helper/c.dart';
import '../support/array.dart';
import '../support/caster.dart';
import '../support/collection.dart';

class ValidationRuleParser {


  ///The data being validated.
  Map data;

  ValidationRuleParser(this.data);

  var implicitAttributes;


  _explodeRules(Collection rules) {

    rules.forEach((key, rule) {

        rules[key] = _explodeExplicitRule(rule);

    });
    return rules;
  }



  _explodeExplicitRule(rule) {
    if (rule is String) {
      return rule.split("|");
    } else if (!C.isScalar(rule)) {
      return [this._prepareRule(rule)];
    }

    return Array(rule).map((e) => _prepareRule(e)).toList();
  }
  _prepareRule(rule) {
    if(rule is Function) {
      return ClosureRule(rule);
    }

    if(C.isScalar(rule) ||    rule is RuleInterface ) {
      return rule;
    }


    return rule.toString();
  }



  Tuple explode(rules) {
    this.implicitAttributes = [];
    var abcc = this._explodeRules(rules);

    rules = abcc;
    print(rules);
    return Tuple(rules,implicitAttributes);
  }

  static Tuple parse(rules) {
    if (rules is RuleInterface) {
      return Tuple(rules, []);
    }

    if (C.isArray(rules)) {
      rules = parseArrayRule(rules);
    } else {
      rules = parseStringRule(rules);
    }

    rules[0] = normalizeRule(rules[0]);
    print(rules);
    return Tuple.fromList(rules);
  }

  ///Parse an array based rule.
  static parseArrayRule(rules)   {
    return [Str.studly(Str.trim(Arr.get(rules, 0))), rules.sublist(1)];
  }

   ///Parse a string based rule.

  static parseStringRule(rules) {
    List parameters = [];

    // The format for specifying validation rules and parameters follows an
    // easy {rule}:{parameters} formatting convention. For instance the
    // rule "Max:3" states that the value may only be three letters.
    if (Str.strpos(rules, ':') != false) {
      List exploded = Str.explode(':', rules, 2);
      rules = exploded[0];
      String parameter = exploded[1];
      parameters = parseParameters(rules, parameter);
  }

    return Tuple(Str.studly(Str.trim(rules)), parameters);
  }

  ///Parse a parameter list.

   static List parseParameters(String rule, String parameter) {
    rule = rule.toLowerCase();

    if(['regex', 'not_regex', 'notregex'].contains(rule)) {
      return [parameter];
    }


    return Str.getcsv(parameter);
  }

  ///Normalizes a rule so that we can accept short types.
   static normalizeRule(rule){
    switch (rule) {
      case 'Int':
        return 'Integer';
      case 'Bool':
        return 'Boolean';
      default:
        return rule;
    }
  }
}