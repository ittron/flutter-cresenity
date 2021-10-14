import 'package:example/api/exception/api_error_exception.dart';
import 'package:example/api/exception/api_http_exception.dart';

class ApiOptions {
  Function(ApiHttpException) onException;
  Function(ApiErrorException) onError;

  ApiOptions({this.onException, this.onError});
}
