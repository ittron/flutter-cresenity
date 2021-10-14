import 'package:example/api/api_runner.dart';
import 'package:example/api/api_runner_abstract.dart';
import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/http/response.dart';

class ApiDataModelRunner<T extends AbstractDataModel>
    extends ApiRunnerAbstract {
  ApiDataModelRunner(ApiRunner runner) : super(runner);

  Future<T> run(String method, [params]) async {
    Response response = await runner.run(method, params);
    return runner.convertToDataModel<T>(response);
  }
}
