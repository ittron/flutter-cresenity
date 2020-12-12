




import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cresenity/support/array.dart';

void main() {



  test("Test Str.ucwords", () {
    String value = "hello World";
    value = Str.ucwords(value);
    expect(value,"Hello World");
  });

  test("Test Str.studly", () {
    String value = "hello World";
    value = Str.studly(value);
    expect(value,"HelloWorld");
  });


  test("Test Str.replace", () {

    expect(Str.replace(' ', '.', 'Kevin van Zonneveld'),'Kevin.van.Zonneveld');
    expect(Str.replace(['{name}', 'l'], ['hello', 'm'], '{name}, lars'),'hemmo, mars');
    expect(Str.replace(Array(['S','F']),'x','ASDFASDF'),'AxDxAxDx');
    expect(Str.replace(['A','D'], ['x','y'] , 'ASDFASDF'),'xSyFxSyF');

  });

}