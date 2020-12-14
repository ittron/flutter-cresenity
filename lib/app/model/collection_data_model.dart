


import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/support/collection.dart';

class CollectionDataModel extends Collection implements AbstractDataModel {
  CollectionDataModel([items]): super(items);

  CollectionDataModel.fromJson(Map<String,dynamic> map) {
    setItems(map);

  }


  @override
  Map<String, dynamic > toJson() => all();

}