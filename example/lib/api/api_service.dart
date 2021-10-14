import 'package:example/api/api_options.dart';
import 'package:example/api/api_runner.dart';
import 'package:example/api/exception/api_error_exception.dart';
import 'package:example/api/exception/api_http_exception.dart';
import 'package:example/api/runner/api_data_model_runner.dart';
import 'package:example/api/runner/api_response_model_runner.dart';
import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/http/response.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiService {
  ApiService._();
  static ApiService _instance = ApiService._();

  factory ApiService.instance() {
    return _instance;
  }
  static String authId = 'xxx';
  static String baseUrl = 'http://mocky.app.ittron.co.id/api/mock/';

  Function _defaultOnException = (ApiHttpException e) {
    print(e.toString());
  };
  Function _defaultOnError = (ApiErrorException error) {
    _showToast(error.toString());
  };

  static void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
    );
  }

  ApiRunner withOptions(
      {Function(ApiHttpException) onException,
      Function(ApiErrorException) onError}) {
    ApiOptions apiOptions =
        ApiOptions(onException: _defaultOnException, onError: _defaultOnError);
    return ApiRunner(apiOptions);
  }

  ApiRunner withOnError(Function(ApiErrorException) onError) {
    return withOptions(onError: onError);
  }

  ApiRunner withOnException(Function(ApiHttpException) onException) {
    return withOptions(onException: onException);
  }

  Future<Response> run(String method, [params]) async {
    return await withOptions().run(method, params);
  }

  ApiDataModelRunner toDataModel<T extends AbstractDataModel>() {
    return ApiDataModelRunner<T>(withOptions());
  }

  ApiResponseModelRunner toResponseModel<T extends AbstractDataModel>() {
    return ApiResponseModelRunner<T>(withOptions());
  }
}
