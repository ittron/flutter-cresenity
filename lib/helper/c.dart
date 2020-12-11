
import 'dart:math';

import 'package:flutter/material.dart';

class C {

  static T tap<T>(T value, Function(T) callback) {
    callback(value);
    return value;
  }

  static dynamic using<T>(T value, Function(T) callback) {
    return callback == null ? value : callback(value);
  }


  static bool isScalar(Object value) {
    if(value==null) {
      return true;
    }
    return value is String || value is int || value is bool;
  }


  static int random(int from , int to) {
    /// Generates a random integer where [from] <= [to].
    if (from > to) {
      int temp = to; to=from; from=temp;
    }
    var randomDouble = Random().nextDouble();
    if (randomDouble < 0) randomDouble *= -1;
    if (randomDouble > 1) randomDouble = 1 / randomDouble;
    return ((to - from) * Random().nextDouble()).toInt() + from;


  }

}
