import 'package:flutter_cresenity/app/model/model_factory.dart';
import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/helper/arr.dart';

import 'abstract_data_model.dart';
import 'abstract_model.dart';

class ResponsePaginationModel<T extends AbstractDataModel>
    extends AbstractModel {
  int errCode = 0;
  String errMessage = '';

  PaginationDataModel<T>? data;

  ResponsePaginationModel();

  ResponsePaginationModel.fromJson(Map<String, dynamic> json,
      [Function? factoryBuilder]) {
    errCode = Arr.getInt(json, 'errCode');
    errMessage = Arr.getString(json, 'errMessage');

    factoryBuilder = ModelFactory.instance().resolveBuilder(T, factoryBuilder);
    data = PaginationDataModel<T>.fromJson(
        Arr.getMap(json, 'data'), factoryBuilder);
  }

  bool isError() {
    return errCode > 0 ? true : false;
  }

  @override
  Map<String, dynamic> toJson() => {
        'errCode': errCode,
        'errMessage': errMessage,
        'data': data?.toJson(),
      };
}
