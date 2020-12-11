

import 'dart:convert';

import 'package:flutter_cresenity/interface/jsonable.dart';

abstract class AbstractModel implements Jsonable{
  AbstractModel();

  AbstractModel.fromJson(Map map);

  Map<String,dynamic> toJson();

  String toString() {
    return jsonEncode(toJson());
  }
}
