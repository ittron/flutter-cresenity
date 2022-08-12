import '../storage_adapter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageAdapter extends StorageAdapter {
  final String boxKey = 'CFHive';
  FlutterSecureStorage storage;
  Map<String, String> storageCache;

  FlutterSecureStorageAdapter() {
    storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
  }
  Future<void> setup() async {
    storageCache = await storage.readAll();
  }

  String get(String key, {String defaultValue}) {
    if (!storageCache.containsKey(key)) {
      return defaultValue;
    }
    return storageCache[key];
  }

  Future<bool> put(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
      storageCache[key] = value;
    } catch (ex) {
      return false;
    }
    return true;
  }

  Future<bool> unset(String key) async {
    if (await storage.containsKey(key: key)) {
      await storage.delete(key: key);
      storageCache.remove(key);
      return true;
    }
    return false;
  }
}
