import 'dart:convert';

import 'array.dart';
import 'caster.dart';
import 'package:flutter_cresenity/helper/c.dart';
import 'package:flutter_cresenity/helper/arr.dart';

class Collection<T> {
  Map<String, T> _items = Map<String, T>();

  Map<String, T> all() {
    return _items;
  }

  Collection([dynamic items]) {
    _items = _getMapableItems(items);
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

  _getMapableItems(dynamic items) {
    if (items == null) {
      return Map<String, T>();
    }
    if (items is Collection) {
      return items.all();
    } else if (items is Map<String, T>) {
      return items;
    } else if (items is Map<dynamic, dynamic>) {
      Map<String, T> newItems = {};
      items.forEach((i, value) {
        Caster cast = Caster(i);
        newItems[cast.toString()] = value;
      });
      return newItems;
    } else if (items is List) {
      Map<String, T> newItems = {};
      items.asMap().forEach((i, value) {
        newItems[i.toString()] = value;
      });
      return newItems;
    } else if (C.isScalar(items)) {
      Map<String, T> newItems = {};
      newItems["0"] = items;
      return newItems;
    }

    return Map<String, dynamic>();
  }

  first() {
    return toArray().first();
  }

  Collection sortBy(Function callback, [bool descending = false]) {
    Collection results = Collection();
    // First we will loop through the items and get the comparator from a callback
    // function which we were given. Then, we will sort the returned values and
    // and grab the corresponding values for the sorted keys from this array.
    _items.forEach((key, value) {
      results[key] = callback(key, value);
    });

/*
    var sortedKeys = results.keys.toList(growable: false)
      ..sort((k1, k2) => results[k1].compareTo(results[k2]));


    LinkedHashMap sortedMap = new LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => results[k]);
*/
    // Once we have sorted all of the keys in the array, we will loop through them
    // and grab the corresponding model so we can set the underlying items list
    // to the sorted version. Then we'll just return the collection instance.
    results.keys.forEach((key) {
      results[key] = _items[key];
    });

    return results;
  }

  dynamic get(String key, [defaultValue]) {
    return Arr.get(_items, key, defaultValue);
  }

  Map<String, T> toMap() {
    return _items;
  }

  Collection set(String key, value) {
    Arr.set(_items, key, value);
    return this;
  }

  Collection setItems(Map<String, T> map) {
    _items = map;
    return this;
  }

  Array toArray() {
    Array arr = Array();
    _items.forEach((key, value) {
      arr[Caster(key).toInt()] = value;
    });
    return arr;
  }

  @override
  String toString() {
    return jsonEncode(_items);
  }

  Collection merge(Collection<T> other) {
    _items.addAll(other.all());
    return this;
  }

  Collection mapWithKeys(Function callback) {
    Collection result = Collection();
    _items.forEach((key, value) {
      Map assoc = callback(key, value);
      assoc.forEach((key, value) {
        result[key] = value;
      });
    });

    return result;
  }

  Collection filter([bool Function(String, T)? f]) {
    if (f != null) {
      return new Collection(Arr.where(_items, f));
    }
    return new Collection(Arr.filter(_items));
  }

  ///alias of length
  int count() {
    return length;
  }

  Collection clear() {
    _items.clear();
    return this;
  }

  void addAll(Map<String, T> other) {
    _items.addAll(other);
  }

  void addEntries(Iterable<MapEntry<String, T>> newEntries) {
    _items.addEntries(newEntries);
  }

  Map<RK, RV> cast<RK, RV>() {
    return _items.cast<RK, RV>();
  }

  bool containsKey(Object key) {
    return _items.containsKey(key);
  }

  bool containsValue(Object value) {
    return _items.containsValue(value);
  }

  Iterable<MapEntry<String, T>> get entries => _items.entries;

  void forEach(void Function(String key, T value) f) {
    _items.forEach(f);
  }

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  Iterable<String> get keys => _items.keys;

  Iterable<T> get values => _items.values;

  int get length => _items.length;

  Collection<V2> map<V2>(MapEntry<String, V2> Function(String key, T value) f) {
    return Collection(_items.map<String, V2>(f));
  }

  T putIfAbsent(String key, T Function() ifAbsent) {
    return _items.putIfAbsent(key, ifAbsent);
  }

  T? remove(Object? key) {
    return _items.remove(key);
  }

  void removeWhere(bool Function(String key, T value) predicate) {
    _items.removeWhere(predicate);
  }

  T update(String key, T Function(T value) update, {T Function()? ifAbsent}) {
    return _items.update(key, update);
  }

  void updateAll(T Function(String key, T value) update) {
    _items.updateAll(update);
  }

  T? operator [](Object key) {
    String keyString = Caster(key).toString();
    return _items[keyString];
  }

  void operator []=(dynamic key, T value) {
    String keyString = Caster(key).toString();
    _items[keyString] = value;
  }
}
