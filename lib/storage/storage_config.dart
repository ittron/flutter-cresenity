



class StorageConfig {
  bool enable = true;
  StorageConfig._();
  static StorageConfig _instance = new StorageConfig._();

  factory StorageConfig.instance() {
    return _instance;
  }


}