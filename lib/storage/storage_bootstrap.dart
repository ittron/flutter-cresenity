



import 'package:flutter_cresenity/interface/bootable.dart';
import 'package:flutter_cresenity/storage/storage.dart';

class StorageBootstrap implements Bootable {
  @override
  Future<void> boot() async {
    // TODO: implement boot
    await Storage.instance().setup();
  }

}