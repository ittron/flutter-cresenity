import '../storage_adapter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageAdapter extends StorageAdapter {
  final String boxKey = 'CFHive';
  FlutterSecureStorage flutterSecureStorage;

  FlutterSecureStorageAdapter() {
    flutterSecureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
  }
  Future<void> setup() async {}

  String get(String key, {String defaultValue}) {
    return box.get(key, defaultValue: defaultValue);
  }

  Future<bool> put(String key, String value) async {
    try {
      await flutterSecureStorage.write(key: key, value: value);
    } catch (ex) {
      return false;
    }
    return true;
  }

  Future<bool> unset(String key) async {
    var box = Hive.box(boxKey);
    if (box.containsKey(key)) {
      await box.delete(key);
      return true;
    }
    return false;
  }
}
