







import 'package:flutter_cresenity/interface/bootable.dart';
import 'package:flutter_cresenity/cf.dart';

import '../cf.dart';

class ValidatorBootstrap implements Bootable  {

  Future<void> boot() async {
    CF.translation.loadRepository("en_US", {
      'validation.accepted' : 'The :attribute must be accepted.',
      'validation.active_url' : 'The :attribute is not a valid URL.',
      'validation.after' : 'The :attribute must be a date after :date.',
      'validation.after_or_equal' : 'The :attribute must be a date after or equal to :date.',
      'validation.alpha' : 'The :attribute may only contain letters.',
      'validation.alpha_dash' : 'The :attribute may only contain letters, numbers, dashes and underscores.',
      'validation.alpha_num' : 'The :attribute may only contain letters and numbers.',
      'validation.array' : 'The :attribute must be an array.',
      'validation.before' : 'The :attribute must be a date before :date.',
      'validation.before_or_equal' : 'The :attribute must be a date before or equal to :date.',
      'validation.between' : {
        'numeric' : 'The :attribute must be between :min and :max.',
        'file' : 'The :attribute must be between :min and :max kilobytes.',
        'string' : 'The :attribute must be between :min and :max characters.',
        'array' : 'The :attribute must have between :min and :max items.',
      },
      'validaton.boolean' : 'The :attribute field must be true or false.',
      'validation.confirmed' : 'The :attribute confirmation does not match.',
      'validation.date' : 'The :attribute is not a valid date.',
      'validation.date_equals' : 'The :attribute must be a date equal to :date.',
      'validation.date_format' : 'The :attribute does not match the format :format.',
      'validation.different' : 'The :attribute and :other must be different.',
      'validation.digits' : 'The :attribute must be :digits digits.',
      'validation.digits_between' : 'The :attribute must be between :min and :max digits.',
      'validation.dimensions' : 'The :attribute has invalid image dimensions.',
      'validation.distinct' : 'The :attribute field has a duplicate value.',
      'validation.email' : 'The :attribute must be a valid email address.',
      'validation.ends_with' : 'The :attribute must end with one of the following: :values.',
      'validation.exists' : 'The selected :attribute is invalid.',
      'validation.file' : 'The :attribute must be a file.',
      'validation.filled' : 'The :attribute field must have a value.',
      'validation.gt' : {
        'numeric': 'The :attribute must be greater than :value.',
        'file': 'The :attribute must be greater than :value kilobytes.',
        'string': 'The :attribute must be greater than :value characters.',
        'array': 'The :attribute must have more than :value items.',
      },
      'validation.gte' : {
        'numeric': 'The :attribute must be greater than or equal :value.',
        'file': 'The :attribute must be greater than or equal :value kilobytes.',
        'string': 'The :attribute must be greater than or equal :value characters.',
        'array': 'The :attribute must have :value items or more.',
      },
      'validation.image' : 'The :attribute must be an image.',
      'validation.in' : 'The selected :attribute is invalid.',
      'validation.in_array' : 'The :attribute field does not exist in :other.',
      'validation.integer' : 'The :attribute must be an integer.',
      'validation.ip' : 'The :attribute must be a valid IP address.',
      'validation.ipv4' : 'The :attribute must be a valid IPv4 address.',
      'validation.ipv6' : 'The :attribute must be a valid IPv6 address.',
      'validation.json' : 'The :attribute must be a valid JSON string.',
      'validation.lt' : {
        'numeric': 'The :attribute must be less than :value.',
        'file': 'The :attribute must be less than :value kilobytes.',
        'string': 'The :attribute must be less than :value characters.',
        'array': 'The :attribute must have less than :value items.',
      },
      'validation.lte' : {
        'numeric': 'The :attribute must be less than or equal :value.',
        'file': 'The :attribute must be less than or equal :value kilobytes.',
        'string': 'The :attribute must be less than or equal :value characters.',
        'array': 'The :attribute must not have more than :value items.',
      },
      'validation.max' : {
        'numeric': 'The :attribute may not be greater than :max.',
        'file': 'The :attribute may not be greater than :max kilobytes.',
        'string': 'The :attribute may not be greater than :max characters.',
        'array': 'The :attribute may not have more than :max items.',
      },
      'validation.mimes' : 'The :attribute must be a file of type: :values.',
      'validation.mimetypes' : 'The :attribute must be a file of type: :values.',
      'validation.min' : {
        'numeric': 'The :attribute must be at least :min.',
        'file': 'The :attribute must be at least :min kilobytes.',
        'string': 'The :attribute must be at least :min characters.',
        'array': 'The :attribute must have at least :min items.',
      },
      'validation.multiple_of' : 'The :attribute must be a multiple of :value',
      'validation.not_in' : 'The selected :attribute is invalid.',
      'validation.not_regex' : 'The :attribute format is invalid.',
      'validation.numeric' : 'The :attribute must be a number.',
      'validation.password' : 'The password is incorrect.',
      'validation.present' : 'The :attribute field must be present.',
      'validation.regex' : 'The :attribute format is invalid.',
      'validation.required' : 'The :attribute field is required.',
      'validation.required_if' : 'The :attribute field is required when :other is :value.',
      'validation.required_unless' : 'The :attribute field is required unless :other is in :values.',
      'validation.required_with' : 'The :attribute field is required when :values is present.',
      'validation.required_with_all' : 'The :attribute field is required when :values are present.',
      'validation.required_without' : 'The :attribute field is required when :values is not present.',
      'validation.required_without_all' : 'The :attribute field is required when none of :values are present.',
      'validation.same' : 'The :attribute and :other must match.',
      'validation.size' : {
        'numeric': 'The :attribute must be :size.',
        'file': 'The :attribute must be :size kilobytes.',
        'string': 'The :attribute must be :size characters.',
        'array': 'The :attribute must contain :size items.',
      },
      'validation.starts_with' : 'The :attribute must start with one of the following: :values.',
      'validation.string' : 'The :attribute must be a string.',
      'validation.timezone' : 'The :attribute must be a valid zone.',
      'validation.unique' : 'The :attribute has already been taken.',
      'validation.uploaded' : 'The :attribute failed to upload.',
      'validation.url' : 'The :attribute format is invalid.',
      'validation.uuid' : 'The :attribute must be a valid UUID.',
    });
  }
}
