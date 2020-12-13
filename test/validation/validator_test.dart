




import 'package:flutter_cresenity/validation/validation_factory.dart';
import 'package:flutter_cresenity/validation/validator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/cf.dart';

void main() {
  CF.init();
  test("simple validation", () {


    Map data = {
      "email":"john@example.com",
      "name":"John Doe",
    };
    Validator validator = ValidationFactory.instance().make(data, {
      "email":  ['required','email'],
      "name": "required|max:255"
    });


    expect(validator!=null,true);

    var errors = validator.errors();


    print(errors.get("name"));

  });
}