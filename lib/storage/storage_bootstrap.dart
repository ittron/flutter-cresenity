import 'package:flutter_cresenity/interface/bootable.dart';
import 'package:flutter_cresenity/storage/storage.dart';
import 'package:flutter_cresenity/storage/storage_config.dart';

class StorageBootstrap implements Bootable {
  @override
  Future<void> boot() async {
    if (StorageConfig.instance().enable) {
      await Storage.instance().setup();
    }
  }
}
