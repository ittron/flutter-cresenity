
import 'dart:convert';

import 'package:flutter_cresenity/app/model/collection_data_model.dart';
import 'package:flutter_cresenity/app/model/model_factory.dart';
import 'package:flutter_cresenity/app/model/model_interface.dart';
import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/helper/arr.dart';

import 'abstract_data_model.dart';
import 'abstract_model.dart';



class ResponseModel<T extends AbstractDataModel> extends AbstractModel {
  int errCode;
  String errMessage;

  T data;

  ResponseModel();

  ResponseModel.fromJson(Map<String,dynamic> json, [Function(Map) factoryBuilder]) {
    errCode = Arr.getInt(json,'errCode');
    errMessage = Arr.getString(json,'errMessage');
    factoryBuilder = ModelFactory.instance().resolveBuilder(T,factoryBuilder);

    data = Arr.getMap(json, 'data')!=null ? factoryBuilder(Arr.getMap(json, 'data')) : null;


  }

  bool isError() {
    return errCode>0 ? true:false;
  }

  @override
  Map<String, dynamic> toJson() => {
    'errCode':errCode,
    'errMessage':errMessage,
    'data':data.toJson(),
  };
}
