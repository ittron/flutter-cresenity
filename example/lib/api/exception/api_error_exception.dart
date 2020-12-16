import 'package:example/api/api_error.dart';

class ApiErrorException implements Exception {
  final ApiError error;

  ApiErrorException(this.error);

  String toString() {
    if (error == null) {
      return 'ApiErrorException:Unknown Error';
    }
    return error.toString();
  }
}
