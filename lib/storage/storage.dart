import 'package:flutter_cresenity/storage/storage_adapter.dart';
import 'package:flutter_cresenity/storage/storage_config.dart';
import 'package:flutter_cresenity/storage/storage_factory.dart';

class Storage {
  static const String ADAPTER_FLUTTER_SECURE_STORAGE = 'flutter_secure_storage';
  static const String DEFAULT_ADAPTER = ADAPTER_FLUTTER_SECURE_STORAGE;

  Storage._({String adapter = DEFAULT_ADAPTER}) {
    _adapterType = adapter;
    _adapter = StorageFactory.createAdapter(adapter);
  }

  static Map<String, Storage> _instance;

  String _adapterType = DEFAULT_ADAPTER;
  factory Storage.instance({String adapter}) {
    if (adapter == null) {
      adapter = DEFAULT_ADAPTER;
    }

    if (_instance == null) {
      _instance = Map<String, Storage>();
    }
    if (!_instance.containsKey(adapter)) {
      _instance[adapter] = Storage._();
    }

    return _instance[adapter];
  }

  StorageAdapter _adapter;
  get adapterType => _adapterType;

  void setAdapterType(String type) {
    this._adapterType = type;
  }

  Future<void> setup() async {
    if (StorageConfig.instance().enable) {
      await _adapter.setup();
    }
  }

  String get(String key, {String defaultValue}) {
    return _adapter.get(key, defaultValue: defaultValue);
  }

  Future<bool> put(String key, String value) async {
    return await _adapter.put(key, value);
  }

  void unset(String key) async {
    await _adapter.unset(key);
  }
}
