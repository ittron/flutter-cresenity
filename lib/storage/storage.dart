


import 'package:flutter_cresenity/storage/storage_adapter.dart';
import 'package:flutter_cresenity/storage/storage_factory.dart';

class Storage {
  static const String ADAPTER_HIVE = 'hive';
  static const String DEFAULT_ADAPTER = ADAPTER_HIVE;

  Storage._({String adapter = DEFAULT_ADAPTER}) {
    _adapterType = adapter;
    _adapter = StorageFactory.createAdapter(adapter);
  }

  static  Map<String,Storage> _instance;

  String _adapterType = DEFAULT_ADAPTER;
  factory Storage.instance({String adapter}) {
    if(adapter==null) {
      adapter=DEFAULT_ADAPTER;
    }


    if(_instance==null) {
      _instance = Map<String,Storage>();
    }
    if(!_instance.containsKey(adapter)) {
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

    await _adapter.setup();
  }



  String get(String key,{String defaultValue}) {
    return _adapter.get(key,defaultValue: defaultValue);
  }

  void put(String key,String value) async {
    await _adapter.put(key,value);
  }

  void unset(String key) async {
    await _adapter.unset(key);
  }

  Future<bool> putWait(String key,String value) {
    return _adapter.put(key,value);
  }

}