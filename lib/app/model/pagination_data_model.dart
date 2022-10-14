import 'package:flutter_cresenity/support/caster.dart';

import 'abstract_model.dart';

class PaginationDataModel<T extends AbstractModel> {
  int total = 0;
  int lastPage = 0;
  int perPage = 10;
  int currentPage = 1;

  late AbstractModel model;

  List<T> items = List<T>.empty(growable: true);

  PaginationDataModel(this.model) {
    reset();
  }

  fromJson(Map<String, dynamic> map) {
    _getPagination(map);

    if (currentPage > 1) {
      merge(map);
    } else {
      items = List<T>.from(map['items'].map((e) => model.fromJson(e)));
    }
  }

  merge(Map<String, dynamic> map) {
    _getPagination(map);

    items.addAll(List<T>.from(map['items'].map((e) => model.fromJson(e))));
  }

  _getPagination(Map<String, dynamic> map) {
    total = Caster(map['total']).toInt();
    lastPage = Caster(map['lastPage']).toInt();
    perPage = Caster(map['perPage']).toInt();
    currentPage = Caster(map['currentPage']).toInt();
  }

  void reset() {
    currentPage = 1;
    items = List<T>.empty(growable: true);
  }

  updateFromModel(PaginationDataModel<T> model) {
    total = model.total;
    lastPage = model.lastPage;
    perPage = model.perPage;
    currentPage = model.currentPage;
    items.addAll(model.items);
  }

  int remainPage() {
    return lastPage - currentPage;
  }

  Map<String, dynamic> toJson() => {"total": total, "lastPage": lastPage, "perPage": perPage, "currentPage": currentPage, "items": items.map((e) => e.toJson()).toList()};
}
