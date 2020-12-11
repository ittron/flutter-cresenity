
import 'dart:convert';

import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/helper/arr.dart';

import 'abstract_data_model.dart';
import 'abstract_model.dart';



class ResponseModel<T extends AbstractDataModel> implements AbstractModel {
  int errCode;
  String errMessage;

  T data;

  ResponseModel();

  /// Add factory functions for every Type and every constructor you want to make available to `make`

  static Map<Type, Function> factories =  {
    PaginationDataModel: (Map map, Function(Map) factoryBuilder) => PaginationDataModel.fromJson(map,factoryBuilder),
  };

  static registerFactory(Type t,Function f) {
    factories[t]=f;
  }

  ResponseModel.fromJson(Map<String,dynamic> json, Function(Map) factoryBuilder) {
    errCode = Arr.getInt(json,'errCode');
    errMessage = Arr.getString(json,'errMessage');
    //if(T.toString().startsWith("PaginationDataModel")) {
      //data = factories[PaginationDataModel](Arr.getMap(json, 'data'), factoryBuilder);
      //data = PaginationDataModel<T>.fromJson(Arr.getMap(json, 'data'), factoryBuilder);
    //} else {
      //if (factories.containsKey(T)) {
        //data = factories[T](Arr.getMap(json, 'data'), factoryBuilder);
      //} else {
        data = factoryBuilder(Arr.getMap(json, 'data'));
      //}
    //}


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
