import 'package:flutter_cresenity/app/model/collection_data_model.dart';
import 'package:flutter_cresenity/app/model/model_factory.dart';
import 'package:flutter_cresenity/interface/bootable.dart';

class ModelBootstrap implements Bootable {
  Future<void> boot() async {
    ModelFactory.instance().registerBuilder(CollectionDataModel, (map) {
      return CollectionDataModel.fromJson(map);
    });
  }
}
