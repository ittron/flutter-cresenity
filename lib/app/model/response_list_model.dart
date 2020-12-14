



import 'dart:convert';

import 'package:flutter_cresenity/app/model/collection_data_model.dart';
import 'package:flutter_cresenity/app/model/model_factory.dart';
import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/helper/arr.dart';
import 'package:flutter_cresenity/support/array.dart';

import 'abstract_data_model.dart';
import 'abstract_model.dart';




class ResponseListModel<T extends AbstractDataModel> implements AbstractModel {
  int errCode;
  String errMessage;

  Array<T> data;

  ResponseListModel._();

  ResponseListModel.fromJson(Map<String,dynamic> json, [Function(Map) factoryBuilder]) {
    errCode = Arr.getInt(json,'errCode');
    errMessage = Arr.getString(json,'errMessage');
    factoryBuilder = ModelFactory.instance().resolveBuilder(T,factoryBuilder);

    //data = factoryBuilder(Arr.getMap(json, 'data'));
    data = Array();
    Arr.getArray<Map>(json, "data").forEach((element) {
      data.add(factoryBuilder(element));
    });

  }

  bool isError() {
    return errCode>0 ? true:false;
  }

  @override
  Map<String, dynamic> toJson() => {
    'errCode':errCode,
    'errMessage':errMessage,
    'data': data.map((e) => e.toJson()).toList(),
  };
}
