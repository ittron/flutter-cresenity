import '../support/collection.dart';

class Repository {
  Collection _data;

  Repository([Collection data]) {
    _data = Collection(data);
  }

  Collection get data => _data;

  Repository setData(Collection data) {
    this._data = data;
    return this;
  }
}
