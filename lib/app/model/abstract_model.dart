

import 'dart:convert';

abstract class AbstractModel {
  AbstractModel();

  AbstractModel.fromJson(Map map);

  Map<String,dynamic> toJson();

  String toString() {
    return jsonEncode(toJson());
  }
}
