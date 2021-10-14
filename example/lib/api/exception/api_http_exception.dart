import 'package:flutter_cresenity/http/response.dart';

class ApiHttpException implements Exception {
  final String message;
  final Response response;
  ApiHttpException(this.message, [this.response]);

  String toString() {
    if (message == null) {
      return 'ApiHttpException';
    }
    if (response != null) {
      if (response.statusCode != 200) {
        return 'Error Server (${response.statusCode})';
      } else {
        return 'cannot parse response from api';
      }
    }

    return 'ApiHttpException: ' + message;
  }
}
