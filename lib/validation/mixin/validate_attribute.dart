




import 'package:flutter_cresenity/validation/validator/email_validator.dart';
import 'package:flutter_cresenity/validation/validator_abstract.dart';
import 'package:flutter_cresenity/helper/c.dart';

import '../../support/caster.dart';


mixin ValidateAttribute on ValidatorAbstract {
  ///Validate that a required attribute exists.

  validateRequired(attribute, value){
    if (value==null) {
      return false;
    } else if (value is String && value.trim() == '') {
      return false;
    } else if (C.isArray(value) && value.length<1) {
      return false;
    } else if (C.isCollection(value) && value.length<1) {
      return false;
    }
    return true;
  }


  ///Validate that an attribute is a valid e-mail address.

  bool validateEmail(attribute, value, parameters) {
    return EmailValidator.validate(value);
  }

  /**
   * Validate the size of an attribute is less than a maximum value.
   *
   * @param  string  $attribute
   * @param  mixed  $value
   * @param  array  $parameters
   * @return bool
   */
  bool validateMax(attribute, value, parameters)
  {
    this.requireParameterCount(1, parameters, 'max');

    /*
  if ($value instanceof UploadedFile && ! $value->isValid()) {
  return false;
  }

     */


    return this.getSize(attribute, value) <= Caster(parameters[0]).toDouble();
  }


  ///Require a certain number of parameters to be present.

  ///@throws ArgumentError

  void requireParameterCount(int count, List parameters, String rule) {
    if (parameters.length < count) {
      throw new ArgumentError("Validation rule $rule requires at least $count parameters.");
    }
  }


  /**
   * Get the size of an attribute.
   *
   * @param  string  $attribute
   * @param  mixed  $value
   * @return mixed
   */
  getSize(attribute, value) {
    bool hasNumeric = this.hasRule(attribute, this.numericRules);



    // This method will determine if the attribute is a number, string, or file and
    // return the proper size accordingly. If it is a number, then number itself
    // is the size. If it is a file, we take kilobytes, and for a string the
    // entire length of the string will be considered the attribute size.
    if (C.isNumeric(value) && hasNumeric) {
      return value;
    } else if (C.isArray(value) || C.isCollection(value)) {
      return value.length;
    } /*else if ($value instanceof File) {
    return $value->getSize() / 1024;
    }
  */


    return value.toString().length;
  }
}