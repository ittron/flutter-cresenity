import 'package:flutter_cresenity/helper/c.dart';

///this function to cast variable in dart like php

class Caster {
  Object? value;
  Caster(Object value) {
    this.value = value;
  }

  bool isScalar() {
    return C.isScalar(value);
  }

  @override
  String toString() {
    if (value == null) {
      return "";
    }
    if (value is String) {
      return (value as String);
    }
    if (value is bool) {
      return (value as bool) ? "1" : "";
    }
    if (value is int) {
      return value.toString();
    }

    return value.toString();
  }

  bool toBool() {
    if (value == null) {
      return false;
    }
    if (value is int) {
      return (value as int) > 0 ? true : false;
    }
    if (value is String) {
      return value.toString().length > 0;
    }

    return true;
  }

  int toInt() {
    if (value == null) {
      return 0;
    }
    if (value is int) {
      return (value as int);
    }
    if (value is bool) {
      return (value as bool) ? 1 : 0;
    }
    if (value is String) {
      return int.parse((value as String));
    }
    return int.parse((value as String));
  }

  double toDouble() {
    if (value == null) {
      return 0;
    }
    if (value is double) {
      return (value as double);
    }
    if (value is bool) {
      return (value as bool) ? 1 : 0;
    }
    if (value is String) {
      return double.parse((value as String));
    }
    return double.parse((value as String));
  }
}
