import 'dart:math';

import 'package:flutter_cresenity/support/array.dart';

import '../support/collection.dart';

class C {
  static tap(value, Function callback) {
    callback(value);
    return value;
  }

  static dynamic using<T>(T value, Function(T)? callback) {
    return callback == null ? value : callback(value);
  }

  static bool isScalar(Object? value) {
    if (value == null) {
      return true;
    }
    return value is String || value is int || value is bool;
  }

  static int random(int from, int to) {
    /// Generates a random integer where [from] <= [to].
    if (from > to) {
      int temp = to;
      to = from;
      from = temp;
    }
    var randomDouble = Random().nextDouble();
    if (randomDouble < 0) randomDouble *= -1;
    if (randomDouble > 1) randomDouble = 1 / randomDouble;
    return ((to - from) * Random().nextDouble()).toInt() + from;
  }

  static bool isArray(value) {
    return (value is Array) || (value is List);
  }

  static bool isNumeric(value) {
    return value is int || value is double || value is num;
  }

  static bool isCollection(value) {
    return (value is Collection) || (value is Map);
  }

  static value(v) {
    return v is Function ? v() : v;
  }
}
