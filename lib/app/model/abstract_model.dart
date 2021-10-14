

import 'dart:convert';

import 'package:flutter_cresenity/app/model/model_interface.dart';
import 'package:flutter_cresenity/interface/jsonable.dart';

abstract class AbstractModel implements Jsonable, ModelInterface{
  AbstractModel();

  AbstractModel.fromJson(Map map);

  String toString() {
    return jsonEncode(toJson());
  }
}
