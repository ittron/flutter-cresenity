

import 'package:flutter_cresenity/storage/storage_adapter.dart';

import 'storage.dart';
import 'storage_adapter.dart';
import 'adapter/hive_storage_adapter.dart';

class StorageFactory {

  static StorageAdapter createAdapter(adapterType) {
    StorageAdapter adapter;
    switch(adapterType) {
      case Storage.ADAPTER_HIVE:
        adapter = HiveStorageAdapter();
        break;
    }
    return adapter;
  }

}