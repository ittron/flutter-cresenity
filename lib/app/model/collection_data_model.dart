


import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/support/collection.dart';

class CollectionDataModel extends AbstractDataModel{
  Collection items;
  CollectionDataModel.fromJson(Map<String,dynamic> map) {
    this.items = Collection(map);

  }


  @override
  Map<String, dynamic > toJson() => items.all();

}