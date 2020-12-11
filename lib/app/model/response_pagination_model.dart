
import 'dart:convert';

import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/helper/arr.dart';

import 'abstract_data_model.dart';
import 'abstract_model.dart';



class ResponsePaginationModel<T extends AbstractDataModel> implements AbstractModel {
  int errCode;
  String errMessage;

  PaginationDataModel<T> data;

  ResponsePaginationModel();



  ResponsePaginationModel.fromJson(Map<String,dynamic> json, Function(Map) factoryBuilder) {
    errCode = Arr.getInt(json,'errCode');
    errMessage = Arr.getString(json,'errMessage');
    data = PaginationDataModel<T>.fromJson(Arr.getMap(json, 'data'), factoryBuilder);
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
