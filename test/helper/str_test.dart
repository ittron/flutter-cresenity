




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

  test("Test Str.getcsv",(){
    List actual;
    List expected;


    actual = Str.getcsv('"abc","def","ghi"');
    expected = ['abc', 'def', 'ghi'];
    expect(actual,expected);
    actual = Str.getcsv('"row2""cell1","row2cell2","row2cell3"', null, null, '"');
    expected = ['row2"cell1', 'row2cell2', 'row2cell3'];
    expect(actual,expected);

/*

    ///not supported

    actual = Str.getcsv('"row2""cell1",row2cell2,row2cell3', null, null, '"');
    expected = ['row2"cell1', 'row2cell2', 'row2cell3'];

    expect(actual,expected);

    actual = Str.getcsv('row1cell1,"row1,cell2",row1cell3', null, null, '"');
    expected = ['row1cell1', 'row1,cell2', 'row1cell3'];
    expect(actual,expected);
    actual = Str.getcsv('"row2""cell1",row2cell2,"row2""""cell3"');
    expected = ['row2"cell1', 'row2cell2', 'row2""cell3'];
    expect(actual,expected);
    actual = Str.getcsv('row1cell1,"row1,cell2","row1"",""cell3"', null, null, '"');
    expected = ['row1cell1', 'row1,cell2', 'row1","cell3'];
    expect(actual,expected);
*/
  });

}