


import 'package:flutter_cresenity/exception/exception_config.dart';
import 'package:flutter_cresenity/storage/storage_config.dart';

class Config {

  bool enable;
  Config._();
  static Config _instance = new Config._();

  factory Config.instance() {
    return _instance;
  }


  StorageConfig get storage => StorageConfig.instance();
  ExceptionConfig get exception => ExceptionConfig.instance();

}