import 'package:example/api/exception/api_error_exception.dart';

class ApiError {
  final int errCode;
  final String errMessage;
  ApiError(this.errCode, this.errMessage);

  throwException() {
    throw toException();
  }

  ApiErrorException toException() {
    return ApiErrorException(this);
  }

  String toString() {
    if (errMessage == null && errCode == null) {
      return 'Unknown error';
    }
    if (errMessage == null) {
      return 'Unknown error with code:$errCode';
    }
    return errMessage;
  }
}
