


import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cresenity/extension/string_extension.dart';

void main() {

  test("Basic string test", () {
    String str = "Hello world";
    expect(Str.after(str, " "),"world");

    String str4word = "Hello world is awesome";
    expect(Str.after(str4word, " "),"world is awesome");

    //test extension
    expect(str4word.after(" "),"world is awesome");

  });

}