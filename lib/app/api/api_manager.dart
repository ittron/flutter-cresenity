import 'package:flutter_cresenity/app/api/api_request.dart';

class ApiManager {
  ApiManager._();
  static final ApiManager _instance = new ApiManager._();

  factory ApiManager.instance() {
    return _instance;
  }

  ApiRequest createRequest(url, [params]) {
    return ApiRequest(url, params);
  }
}
