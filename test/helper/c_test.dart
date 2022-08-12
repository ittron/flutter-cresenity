import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cresenity/helper/c.dart';

import 'package:flutter_cresenity/support/array.dart';

class DummyObject {
  int _counter;

  void setCounter(int value) {
    _counter = value;
  }

  int getCounter() {
    return _counter;
  }
}

void main() {
  test("Test C.tap", () {
    int value = C.tap(DummyObject(), (item) {
      item.setCounter(2);
    }).getCounter();
    expect(value, 2);
  });

  test("Test C.using", () {
    int value = C.using(DummyObject(), (item) {
      item.setCounter(3);
      return item.getCounter();
    });
    expect(value, 3);
  });

  test("Test C.isArray", () {
    expect(C.isArray([]), true);
    expect(C.isArray(List()), true);

    expect(C.isArray(Array()), true);
  });
}
