import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/support/caster.dart';

import 'abstract_model.dart';

class ResponseModel<T extends AbstractModel> {

  int errCode = 0;
  String errMessage = '';

  late AbstractModel model;
  PaginationDataModel? paginationDataModel;

  dynamic data;

  ResponseModel(this.model);

  ResponseModel.fromJson(Map<String, dynamic> json) {
    _getCode(json);

    if (json['data'] is Map<String, dynamic>) {
      data = model.fromJson(json['data']);
    } else {
      data = List<T>.from(json['data'].map((e) => model.fromJson(e)));
    }
  }

  ResponseModel.paginationJson(Map<String, dynamic> json) {
    _getCode(json);

    paginationDataModel ??= PaginationDataModel<T>(model);

    data = paginationDataModel?.fromJson(json['data']);
  }

  _getCode(Map<String, dynamic> json) {
    errCode = Caster(json['errCode']).toInt();
    errMessage = Caster(json['errMessage']).toString();
  }

  bool isError() {
    return errCode > 0 ? true : false;
  }

  Map<String, dynamic> toJson() => {
        'errCode': errCode,
        'errMessage': errMessage,
        'data': data?.toJson() ?? {},
      };
}
