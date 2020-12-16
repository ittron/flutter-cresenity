import 'package:example/api/api_runner.dart';
import 'package:example/api/api_runner_abstract.dart';
import 'package:flutter_cresenity/http/response.dart';

class ApiResponseRunner extends ApiRunnerAbstract {
  ApiResponseRunner(ApiRunner runner) : super(runner);

  Future<Response> run(String method, [params]) async {
    return await runner.run(method, params);
  }
}
