import 'dart:convert';

import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/app/model/response_model.dart';

class Response {
  final String body;
  final int statusCode;

  Map<String, dynamic> _json;

  Response({this.body, this.statusCode});

  String toString() {
    return "CF.Http.Response " +
        {"statusCode": statusCode, "body": body}.toString();
  }

  Map<String, dynamic> toJson() {
    try {
      _json = json.decode(body) as Map<String, dynamic>;
      // ignore: unused_catch_clause
    } on FormatException catch (e) {}

    return _json;
  }

  ResponseModel<T> toResponseModel<T extends AbstractDataModel>() {
    if (toJson() != null) {
      return ResponseModel<T>.fromJson(jsonDecode(body));
    }
    return null;
  }

  T toDataModel<T extends AbstractDataModel>() {
    ResponseModel<T> responseModel = toResponseModel<T>();
    return responseModel?.data;
  }
}
