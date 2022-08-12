import 'package:flutter_cresenity/storage/storage_adapter.dart';

import 'storage.dart';
import 'storage_adapter.dart';
import 'adapter/flutter_secure_storage_adapter.dart';

class StorageFactory {
  static StorageAdapter createAdapter(adapterType) {
    StorageAdapter? adapter;
    switch (adapterType) {
      case Storage.ADAPTER_FLUTTER_SECURE_STORAGE:
        adapter = FlutterSecureStorageAdapter();
        break;
    }
    return adapter!;
  }
}
