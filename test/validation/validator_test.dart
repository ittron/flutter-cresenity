




import 'package:flutter_cresenity/validation/validation_factory.dart';
import 'package:flutter_cresenity/validation/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("simple validation", () {

    Map data = {
      "email":"johnexample.com",
      "name":"John Doe",
    };
    Validator validator = ValidationFactory.instance().make(data, {
      "email":  "required|email",
      "name":"required|max:255"
    });

    var errors = validator.errors();


    print(errors);

  });
}