import 'dart:collection';
import 'dart:convert';

import 'array.dart';
import 'caster.dart';
import '../helper/c.dart';
import '../helper/arr.dart';

class Collection<T> implements Map<String,T>{

  Map<String,T> _items;

  Map<String,T> all() {
    return _items;
  }


  Collection([Object items]) {
    _items = _getMapableItems(items);
    if(_items==null) {
      clear();
    }
  }


  factory Collection.from(Collection other) {
    Collection<T> result = Collection<T>();
    other.forEach((k, v) {
      result[k] = v;
    });
    return result;
  }

  factory Collection.fromMap(Map other) {
    Collection<T> result = Collection<T>();
    other.forEach((k, v) {
      String kStr = Caster(k).toString();
      result[kStr] = v;
    });
    return result;
  }

  Collection.fromJson(String json) {
    _items = jsonDecode(json);
  }

  _getMapableItems(Object items) {
    if(items==null) {
      return Map<String,T>();
    }
    if (items is Collection) {
      return items.all();
    } else if(items is Map<String,T>) {
      return items;
    } else if(items is Map<dynamic,dynamic>) {

      Map<String,T> newItems = {};
      items.forEach((i, value) {
        Caster cast = Caster(i);
        newItems[cast.toString()] = value;
      });
      return newItems;
    } else if(items is List) {
      Map<String,T> newItems = {};
      items.asMap().forEach((i, value) {
        newItems[i.toString()] = value;
      });
      return newItems;
    } else if(C.isScalar(items)) {


      Map<String,T> newItems = {};
      newItems["0"] = items;
      return newItems;
    }

    return Map<String,dynamic>();
  }



  first() {
    return toArray().first();
  }

  dynamic get(String key,[defaultValue]) {
    return Arr.get(_items,key,defaultValue);

  }

  Collection set(String key, value) {
    Arr.set(_items,key,value);
    return this;
  }

  Collection setItems(Map map) {
    _items = map;
    return this;
  }

  Array toArray() {
    Array arr = Array();
    _items.forEach((key,value){
      arr[Caster(key).toInt()] = value;
    });
    return arr;
  }

  @override
  String toString() {
    return jsonEncode(_items);
  }


  Collection merge(Collection other) {
    _items.addAll(other.all());
    return this;
  }


  /**
   * alias of length
   */
  int count() {
    return length;
  }

  @override
  Collection clear() {
    _items.clear();
    return this;
  }

  @override
  void addAll(Map<String, T> other) {
    _items.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<String, T>> newEntries) {
    _items.addEntries(newEntries);
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    _items.cast<RK, RV>();
  }


  @override
  bool containsKey(Object key) {
    return _items.containsKey(key);
  }

  @override
  bool containsValue(Object value) {
    return _items.containsValue(value);
  }

  @override
  Iterable<MapEntry<String, T>> get entries => _items.entries;

  @override
  void forEach(void Function(String key, T value) f) {
    _items.forEach(f);
  }

  @override
  bool get isEmpty => _items.isEmpty;

  @override
  bool get isNotEmpty =>  _items.isNotEmpty;

  @override
  Iterable<String> get keys => _items.keys;

  @override
  Iterable<T> get values => _items.values;

  @override
  int get length => _items.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(String key, T value) f) {
    return _items.map(f);
  }

  @override
  T putIfAbsent(String key, T Function() ifAbsent) {
    return _items.putIfAbsent(key, ifAbsent);
  }

  @override
  T remove(Object key) {
    return _items.remove(key);
  }

  @override
  void removeWhere(bool Function(String key, T value) predicate) {
    _items.removeWhere(predicate);
  }

  @override
  T update(String key, T Function(T value) update, {T Function() ifAbsent}) {
    return _items.update(key, update);
  }

  @override
  void updateAll(T Function(String key, T value) update) {
    _items.updateAll(update);
  }

  @override
  T operator [](Object key) {
    String keyString = Caster(key).toString();
    return _items[keyString];
  }

  @override
  void operator []=(dynamic key, T value) {
    String keyString = Caster(key).toString();
    _items[keyString] = value;
  }
}
