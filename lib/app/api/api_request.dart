import 'dart:convert';

import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/app/model/response_model.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/http/response.dart';
import 'package:flutter_cresenity/support/collection.dart';

class ApiRequest {
  String _url = '';
  Collection _params = Collection();
  //dynamic _errorHandler;
  dynamic _value;
  Type? _valueType;

  ApiRequest(url, [params]) {
    this._url = url;
    this._params = Collection(params);
  }

  Future<Response?> getResponse() async {
    Response? response;
    try {
      response = await CF.http.waitRequest(
        url: _url,
        method: 'post',
        data: _params,
      );
    } catch (e) {}
    return response;
  }

  Future<ResponseModel<T>?>
      getResponseModel<T extends AbstractDataModel>() async {
    String? responseBody;
    Response? response = await getResponse();
    if (response != null) {
      responseBody = response.body;
    }

    if (responseBody == null) {
      return null;
    }

    ResponseModel<T> responseModel =
        ResponseModel<T>.fromJson(jsonDecode(responseBody));

    if (responseModel.errCode > 0) {
      /*
      service
          .resolveErrorHandler(_errorHandler)
          .handle(ApiError(responseModel.errCode, responseModel.errMessage));
          */
    }

    return responseModel;
  }

  Future<T?> getDataModel<T extends AbstractDataModel>() async {
    ResponseModel<T>? responseModel = await getResponseModel<T>();

    if (_value != null && _getType<T>() == _valueType) {
      _value.value = responseModel?.data;
    }
    return responseModel?.data;
  }

  ApiRequest bindTo<T>(value) {
    _value = value;
    _valueType = _getType<T>();
    return this;
  }

  _getType<T>() {
    return T;
  }
}
