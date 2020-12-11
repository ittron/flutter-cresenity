class Response {

  String body;
  int statusCode;

  Response({this.body,this.statusCode});


  String toString() {
    return "CF.Http.Response " + {
      "statusCode":statusCode,
      "body":body
    }.toString();
  }
}
