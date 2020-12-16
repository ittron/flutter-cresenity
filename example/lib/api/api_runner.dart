import 'package:example/api/api_error.dart';
import 'package:example/api/api_options.dart';
import 'package:example/api/api_service.dart';
import 'package:example/api/exception/api_error_exception.dart';
import 'package:example/api/exception/api_http_exception.dart';
import 'package:example/model/session_model.dart';
import 'package:example/module/disk.dart';
import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/app/model/response_model.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/http/response.dart';

class ApiRunner {
  ApiOptions _options;

  ApiRunner(this._options);

  ApiRunner withOnError(Function(ApiErrorException) onError) {
    _options.onError = onError;
    return this;
  }

  ApiRunner withOnException(Function(ApiHttpException) onException) {
    _options.onException = onException;
    return this;
  }

  toResponseModel<T extends AbstractDataModel>(Response response) {
    ResponseModel<T> model;
    try {
      model = response.toResponseModel<T>();
    } catch (e) {
      _handleException(ApiHttpException(e, response));
    }
    if (model != null) {
      if (model.errCode > 0) {
        _handleError(ApiError(model.errCode, model.errMessage).toException());
      }
    }
    return model;
  }

  Future<SessionModel> _login() async {
    String url = ApiService.baseUrl + "Login";
    Map params = {'authId': ApiService.authId};

    Response response = await _getResponse(url, params, true);
    if (response != null) {
      SessionModel sessionModel = response.toDataModel<SessionModel>();
      if (sessionModel != null) {
        Disk.setSessionId(sessionModel.sessionId);
      }
    }
    return null;
  }

  String sessionId() {
    return Disk.getSessionId();
  }

  bool isAlreadyLogin() {
    return sessionId() != null;
  }

  Future<Response> run(String method, [params]) async {
    String url = ApiService.baseUrl + method;
    if (params == null) {
      params = {};
    }
    if (!isAlreadyLogin()) {
      await _login();
    }

    return _getResponse(url, params);
  }

  Future<Response> _getResponse(url, params, [bool isLogin = false]) async {
    Response response;

    if (isLogin) {
      params['oldSessionId'] = sessionId();
    }

    print("Request:" + url);
    try {
      response =
          await CF.http.waitRequest(url: url, data: params, method: 'post');
    } catch (e) {
      _handleException(ApiHttpException(e, response));
      return null;
    }

    print("Response:" + response.body);

    if (response == null || response?.statusCode != 200) {
      _handleException(ApiHttpException(
          "HTTP status code is ${response.statusCode}", response));
    }

    return response;
  }

  _handleException(ApiHttpException exception) {
    if (_options.onException != null) {
      _options.onException(exception);
    } else {
      throw exception;
    }
  }

  _handleError(ApiErrorException exception) {
    if (_options.onException != null) {
      _options.onError(exception);
    } else {
      throw exception;
    }
  }
}
