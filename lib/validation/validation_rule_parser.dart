import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_cresenity/support/tuple.dart';
import 'package:flutter_cresenity/validation/closure_rule.dart';
import 'package:flutter_cresenity/validation/rule_interface.dart';

import '../helper/arr.dart';
import '../helper/c.dart';
import '../support/array.dart';
import '../support/array.dart';
import '../support/array.dart';
import '../support/array.dart';
import '../support/caster.dart';
import '../support/collection.dart';
import '../support/collection.dart';
import '../support/collection.dart';
import '../support/collection.dart';

class ValidationRuleParser {
  ///The data being validated.
  Collection data;

  ValidationRuleParser(this.data);

  var implicitAttributes;

  Collection<Array> _explodeRules(Collection rules) {
    Collection<Array> result = Collection<Array>();
    rules.forEach((key, rule) {
      result[key] = Array(_explodeExplicitRule(rule));
    });
    return result;
  }

  _explodeExplicitRule(rule) {
    if (rule is String) {
      return Array(rule.split("|"));
    } else if (C.isScalar(rule)) {
      return Array(this._prepareRule(rule));
    }

    return Array(rule).map((e) => _prepareRule(e)).toList();
  }

  _prepareRule(rule) {
    if (rule is Function) {
      return ClosureRule(rule);
    }

    if (C.isScalar(rule) || rule is RuleInterface) {
      return rule;
    }

    return rule.toString();
  }

  Collection<Array> explode(Collection rules) {
    this.implicitAttributes = [];
    return this._explodeRules(rules);
  }

  static List parse(rules) {
    if (rules is RuleInterface) {
      return [rules, []];
    }

    if (C.isArray(rules)) {
      rules = parseArrayRule(Array(rules));
    } else {
      rules = parseStringRule(rules);
    }

    rules[0] = normalizeRule(rules[0]);
    return rules;
  }

  ///Parse an array based rule.
  static List parseArrayRule(Array rules) {
    return [Str.studly(Str.trim(Arr.get(rules, 0))), rules.sublist(1)];
  }

  ///Parse a string based rule.

  static List parseStringRule(rules) {
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

    return [Str.studly(Str.trim(rules)), parameters];
  }

  ///Parse a parameter list.
  static List parseParameters(String rule, String parameter) {
    rule = rule.toLowerCase();

    if (['regex', 'not_regex', 'notregex'].contains(rule)) {
      return [parameter];
    }

    return Str.getcsv(parameter);
  }

  ///Normalizes a rule so that we can accept short types.
  static normalizeRule(rule) {
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
