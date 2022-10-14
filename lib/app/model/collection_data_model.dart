import 'dart:convert';

import 'package:flutter_cresenity/app/model/abstract_data_model.dart';
import 'package:flutter_cresenity/helper/arr.dart';
import 'package:flutter_cresenity/support/array.dart';
import 'package:flutter_cresenity/support/caster.dart';
import 'package:flutter_cresenity/support/collection.dart';

class CollectionDataModel<T> extends AbstractDataModel {
  Collection<T> _items = Collection<T>();
  CollectionDataModel.fromJson(Map<String, dynamic> map) {
    this._items = Collection<T>(map);
  }

  @override
  Map<String, dynamic> toJson() => _items.all();

  T get(String key, [defaultValue]) {
    return Arr.get(_items, key, defaultValue);
  }

  Map<String, T> toMap() {
    return _items.toMap();
  }

  CollectionDataModel set(String key, value) {
    _items.set(key, value);
    return this;
  }

  CollectionDataModel setItems(Map<String, T> map) {
    _items.setItems(map);
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

  CollectionDataModel merge(Collection<T> other) {
    _items.addAll(other.all());
    return this;
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

  CollectionDataModel clear() {
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

  CollectionDataModel<V2> map<V2>(
      MapEntry<String, V2> Function(String key, T value) f) {
    return CollectionDataModel<V2>.fromJson(_items.map<V2>(f).toMap());
  }

  T putIfAbsent(String key, T Function() ifAbsent) {
    return _items.putIfAbsent(key, ifAbsent);
  }

  T? remove(Object key) {
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

  dynamic operator [](Object key) {
    String keyString = Caster(key).toString();
    return _items[keyString];
  }

  void operator []=(dynamic key, T value) {
    String keyString = Caster(key).toString();
    _items[keyString] = value;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
