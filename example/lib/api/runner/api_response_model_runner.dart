import 'package:example/api/api_runner.dart';
import 'package:example/api/api_runner_abstract.dart';
import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/app/model/response_model.dart';
import 'package:flutter_cresenity/http/response.dart';

class ApiResponseModelRunner<T extends AbstractDataModel>
    extends ApiRunnerAbstract {
  ApiResponseModelRunner(ApiRunner runner) : super(runner);

  Future<ResponseModel<T>> run(String method, [params]) async {
    Response response = await runner.run(method, params);
    return runner.convertToResponseModel<T>(response);
  }
}
