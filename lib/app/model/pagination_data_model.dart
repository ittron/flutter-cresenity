import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/app/model/model_factory.dart';
import 'package:flutter_cresenity/helper/arr.dart';
import 'package:flutter_cresenity/support/array.dart';

class PaginationDataModel<T extends AbstractDataModel>
    extends AbstractDataModel {
  int total = 0;
  int lastPage = 0;
  int perPage = 10;
  int currentPage = 1;
  Array<T> items = Array<T>();

  PaginationDataModel() {
    reset();
  }

  PaginationDataModel.fromJson(Map? map, [Function? factoryBuilder]) {
    total = Arr.getInt(map, "total");
    lastPage = Arr.getInt(map, "lastPage");
    perPage = Arr.getInt(map, "perPage");
    currentPage = Arr.getInt(map, "currentPage");

    items = new Array<T>();
    factoryBuilder = ModelFactory.instance().resolveBuilder(T, factoryBuilder);
    Arr.getArray(map, "items").forEach((element) {
      items.add(factoryBuilder!(element));
    });
  }

  void reset() {
    currentPage = 0;
    items = Array();
  }

  updateFromModel(PaginationDataModel<T> model) {
    total = model.total;
    lastPage = model.lastPage;
    perPage = model.perPage;
    currentPage = model.currentPage;
    items.merge(model.items);
  }

  updateFromJson(Map map) {
    total = Arr.getInt(map, "total");
    lastPage = Arr.getInt(map, "lastPage");
    perPage = Arr.getInt(map, "perPage");
    currentPage = Arr.getInt(map, "currentPage");
    items.merge(Arr.getArray(map, "items"));
  }

  int remainPage() {
    return lastPage - currentPage;
  }

  @override
  Map<String, dynamic> toJson() => {
        "total": total,
        "lastPage": lastPage,
        "perPage": perPage,
        "currentPage": currentPage,
        "items": items.map((e) => e.toJson()).toList()
      };
}
