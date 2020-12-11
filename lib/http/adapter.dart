
import 'request.dart';
import 'response.dart';

abstract class Adapter {

  Future<Response> request(Request request);

}
