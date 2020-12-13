




import 'package:flutter_cresenity/support/collection.dart';
import 'package:flutter_cresenity/support/array.dart';
import 'package:flutter_cresenity/support/tuple.dart';
import 'package:flutter_cresenity/translation/translator.dart';
import 'package:flutter_cresenity/helper/arr.dart';
import 'package:flutter_cresenity/validation/validation_rule_parser.dart';

abstract class ValidatorAbstract {
  Collection customMessages;

  Collection data = Collection();
  Translator translator;

  Collection<Array> rules = Collection<Array>();

  ///The array of fallback error messages.
  Collection fallbackMessages;


  Collection implicitAttributes = Collection();

  Collection customAttributes = Collection();

  List<String> sizeRules = ['Size', 'Between', 'Min', 'Max', 'Gt', 'Lt', 'Gte', 'Lte'];

 ///The numeric related validation rules.

  List<String> numericRules = ['Numeric', 'Integer'];
   ///Get the primary attribute name.
   ///
   ///For example, if "name.0" is given, "name.*" will be returned.
  String getPrimaryAttribute(String attribute){

      /*
    foreach ($this->implicitAttributes as $unparsed => $parsed) {
      if (in_array($attribute, $parsed, true)) {
        return $unparsed;
      }
    }
    */
    return attribute;
  }

  ///Get the value of a given attribute.
  getValue(attribute)  {
    return Arr.get(this.data, attribute);
  }


 ///Determine if the given attribute has a rule in the given set.

  bool hasRule(String attribute, rules)
  {
    return this.getRule(attribute, rules)!=null;
  }



  ///Get a rule and its parameters for a given attribute.

  List getRule(attribute, rules){
    if(!this.rules.containsKey(attribute)) {
      return null;
    }

    Array rulesToFind = Array(rules);

    Array ruleArray = this.rules[attribute];
    for(String rule in ruleArray.all()) {
      List tuple = ValidationRuleParser.parse(rule);
      rule = tuple[0];
      List parameters = tuple[1];
      if(rulesToFind.contains(rule)) {
        return [rule, parameters];
      }
    }

    return null;

  }

}