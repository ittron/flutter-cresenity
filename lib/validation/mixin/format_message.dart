import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_cresenity/support/collection.dart';

import 'package:flutter_cresenity/validation/validator_abstract.dart';

import '../../helper/arr.dart';
import '../../helper/c.dart';

mixin FormatMessage on ValidatorAbstract {
  ///Get the validation message for an attribute and rule.

  getMessage(attribute, rule) {
    String? inlineMessage = _getInlineMessage(attribute, rule);

    // First we will retrieve the custom message for the validation rule if one
    // exists. If a custom validation message is being used we'll return the
    // custom message, otherwise we'll keep searching for a valid message.
    if (inlineMessage != null) {
      return inlineMessage;
    }

    String lowerRule = Str.snake(rule);
    String customKey = "validation.custom.$attribute.$lowerRule";
    String customMessage = _getCustomMessageFromTranslator(customKey);

    // First we check for a custom defined validation message for the attribute
    // and rule. This allows the developer to specify specific messages for
    // only some attributes and rules that need to get specially formed.
    if (customMessage != customKey) {
      return customMessage;
    }

    // If the rule being validated is a "size" rule, we will need to gather the
    // specific error message for the type of attribute being validated such
    // as a number, file or string which all have different message types.

    else if (this.sizeRules.contains(rule)) {
      return this._getSizeMessage(attribute, rule);
    }

    // Finally, if no developer specified messages have been set, and no other
    // special messages apply for this rule, we will just pull the default
    // messages out of the translator service for this validation rule.
    String key = "validation.$lowerRule";
    String value = this.translator.get(key);
    if (key != value) {
      return value;
    }

    return _getFromLocalArray(attribute, lowerRule, this.fallbackMessages) ??
        key;
  }

  ///Get the proper inline error message for standard and size rules.

  String? _getInlineMessage(String attribute, String rule) {
    String? inlineEntry = _getFromLocalArray(attribute, Str.snake(rule));

    return inlineEntry;
  }

  ///Get the inline message for a rule if it exists.

  _getFromLocalArray(String attribute, String lowerRule, [source]) {
    Collection customMessage = this.customMessages;
    if (source != null) {
      customMessage = Collection(source);
    }

    List<String> keys = ["$attribute.$lowerRule", lowerRule];

    // First we will check for a custom message for an attribute specific rule
    // message for the fields, then we will check for a general custom line
    // that is not attribute specific. If we find either we'll return it.
    for (int i = 0; i < keys.length - 1; i++) {
      String key = keys[i];
      for (int j = 0; j < customMessage.keys.length; j++) {
        String sourceKey = customMessages.keys.toList()[j];
        if (Str.strpos(sourceKey, '*') != false) {
          String pattern =
              Str.replace(r'\*', r'([^.]*)', Str.pregQuote(sourceKey));
          if (RegExp(r'^' + pattern + r'\z', caseSensitive: false)
              .hasMatch(key)) {
            return customMessage[sourceKey];
          }
          continue;
        }
        if (Str.match(sourceKey, source)) {
          return customMessage[sourceKey];
        }
      }
    }
  }

  ///Get the custom error message from translator.
  String _getCustomMessageFromTranslator(String key) {
    String message = this.translator.get(key);
    if (message != key) {
      return message;
    }
    return key;
  }

  String makeReplacements(
      String message, String attribute, String rule, List parameters) {
    message = _replaceAttributePlaceholder(
        message, getDisplayableAttribute(attribute));

    message = replaceInputPlaceholder(message, attribute);

    return message;
  }

  ///Get the displayable name of the attribute.

  String getDisplayableAttribute(String attribute) {
    String primaryAttribute = getPrimaryAttribute(attribute);

    List<String> expectedAttributes = attribute != primaryAttribute
        ? [attribute, primaryAttribute]
        : [attribute];

    for (String name in expectedAttributes) {
      // The developer may dynamically specify the array of custom attributes on this
      // validator instance. If the attribute exists in this array it is used over
      // the other ways of pulling the attribute name for this given attributes.
      if (customAttributes.containsKey(name)) {
        return customAttributes[name];
      }

      // We allow for a developer to specify language lines for any attribute in this
      // application, which allows flexibility for displaying a unique displayable
      // version of the attribute name instead of the name used in an HTTP POST.
      String? line = this._getAttributeFromTranslations(name);
      if (line != null && line != name) {
        return line;
      }
    }

    // When no language line has been specified for the attribute and it is also
    // an implicit attribute we will display the raw attribute's name and not
    // modify it with any of these replacements before we display the name.
    if (this.implicitAttributes.containsKey(primaryAttribute)) {
      /*
      return ($formatter = $this->implicitAttributesFormatter)
          ? $formatter($attribute)
          : $attribute;
      */
      return attribute;
    }

    return Str.replace('_', ' ', Str.snake(attribute));
  }

  String? _getAttributeFromTranslations(name) {
    return Arr.get(this.translator.get('validation.attributes'), name);
  }

  ///Replace the :attribute placeholder in the given message.

  String _replaceAttributePlaceholder(String message, String value) {
    return Str.replace([':attribute', ':ATTRIBUTE', ':Attribute'],
        [value, Str.upper(value), Str.ucfirst(value)], message);
  }

  ///Replace the :input placeholder in the given message.

  String replaceInputPlaceholder(String message, String attribute) {
    var actualValue = this.getValue(attribute);

    if (C.isScalar(actualValue) || (actualValue == null)) {
      message = Str.replace(
          ':input', getDisplayableValue(attribute, actualValue), message);
    }

    return message;
  }

  ///Get the displayable name of the value.

  String getDisplayableValue(String attribute, value) {
    String key = "validation.values.$attribute.$value";
    String line = this.translator.get(key);
    if (line != key) {
      return line;
    }

    if (value is bool) {
      return value ? 'true' : 'false';
    }

    return value;
  }

  ///Get the proper error message for an attribute and size rule.

  String _getSizeMessage(attribute, rule) {
    String lowerRule = Str.snake(rule);

    // There are three different types of size validations. The attribute may be
    // either a number, file, or string so we will check a few things to know
    // which type of value it is and return the correct line for that type.
    String type = this.getAttributeType(attribute);

    String key = "validation.$lowerRule.$type";

    var a = this.translator.get(key);
    return a;
  }

  ///Get the data type of the given attribute.

  String getAttributeType(String attribute) {
    // We assume that the attributes present in the file array are files so that
    // means that if the attribute does not have a numeric rule and the files
    // list doesn't have it we'll just consider it a string by elimination.
    if (this.hasRule(attribute, this.numericRules)) {
      return 'numeric';
    } else if (this.hasRule(attribute, ['Array'])) {
      return 'array';
    }
    /*
    elseif ($this->getValue($attribute) is UploadedFile) {
  return 'file';
  }

     */

    return 'string';
  }
}
