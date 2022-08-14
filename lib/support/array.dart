import 'dart:math';

import '../helper/arr.dart';
import '../helper/c.dart';
import 'collection.dart';

class Array<E> {
  List<E> _items = <E>[];

  List<E> all() {
    return _items;
  }

  Array([dynamic items]) {
    _items = _getListableItems(items);
  }

  Array clear() {
    _items = <E>[];
    return this;
  }

  _getListableItems(dynamic items) {
    if (items == null) {
      return <E>[];
    }
    if (items is Array) {
      return items.all();
    } else if (items is List) {
      return items;
    } else if (items is Set) {
      return items.toList();
    } else if (items is Map) {
      return items.values;
    } else if (items is Iterable) {
      return items.toList();
    } else if (C.isScalar(items)) {
      List<E> newItems = [];
      newItems.add(items);
      return newItems;
    }

    return <E>[];
  }

  first() {
    if (length > 0) {
      return _items[0];
    }
    return null;
  }

  static Array fromList(List list) {
    return Array(list);
  }

  static Array fromCollection(Collection collection) {
    return collection.toArray();
  }

  E operator [](int key) {
    return get(key);
  }

  dynamic get(int key, [defaultValue]) {
    return Arr.get(_items, key, defaultValue);
  }

  int count() {
    return _items.length;
  }

  int get length => count();

  Array merge(Array<E> other) {
    _items.addAll(other.all());
    return this;
  }

  Array operator +(Array<E> other) {
    return merge(other);
  }

  void operator []=(int index, value) {
    _items[index] = value;
  }

  void add(value) {
    _items.add(value);
  }

  void addAll(Iterable<E> iterable) {
    _items.addAll(iterable);
  }

  bool any(bool Function(E) test) {
    return _items.any(test);
  }

  Map<int, dynamic> asMap() {
    return _items.asMap();
  }

  Collection<dynamic> asCollection() {
    return Collection(_items.asMap());
  }

  bool contains(Object element) {
    return _items.contains(element);
  }

  elementAt(int index) {
    return _items.elementAt(index);
  }

  bool every(bool Function(E) test) {
    return _items.every(test);
  }

  Iterable<T> expand<T>(Iterable<T> Function(E) f) {
    return _items.expand(f);
  }

  void fillRange(int start, int end, [fillValue]) {
    _items.fillRange(start, end, fillValue);
  }

  firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    _items.firstWhere(test, orElse: orElse);
  }

  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    return _items.fold(initialValue, combine);
  }

  Iterable followedBy(Iterable<E> other) {
    return _items.followedBy(other);
  }

  void forEach(void Function(E element) f) {
    _items.forEach(f);
  }

  Iterable getRange(int start, int end) {
    return _items.getRange(start, end);
  }

  int indexOf(element, [int start = 0]) {
    return _items.indexOf(element, start);
  }

  int indexWhere(bool Function(E element) test, [int start = 0]) {
    return _items.indexWhere(test);
  }

  void insert(int index, element) {
    _items.insert(index, element);
  }

  void insertAll(int index, Iterable<E> iterable) {
    _items.insertAll(index, iterable);
  }

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  Iterator get iterator => _items.iterator;

  String join([String separator = ""]) {
    return _items.join(separator);
  }

  int lastIndexOf(element, [int? start]) {
    return _items.lastIndexOf(element, start);
  }

  int lastIndexWhere(bool Function(E element) test, [int? start]) {
    return _items.lastIndexWhere(test, start);
  }

  lastWhere(bool Function(E element) test, {E Function()? orElse}) {
    _items.lastWhere(test, orElse: orElse);
  }

  set length(int newLength) {
    _items.length = newLength;
  }

  Array map<T>(T Function(E e) f) {
    return Array(_items.map<T>(f));
  }

  reduce(E Function(E value, E element) combine) {
    return _items.reduce(combine);
  }

  bool remove(Object value) {
    return _items.remove(value);
  }

  removeAt(int index) {
    return _items.removeAt(index);
  }

  removeLast() {
    return _items.removeLast();
  }

  void removeRange(int start, int end) {
    _items.removeRange(start, end);
  }

  void removeWhere(bool Function(E element) test) {
    _items.removeWhere(test);
  }

  void replaceRange(int start, int end, Iterable<E> replacement) {
    _items.replaceRange(start, end, replacement);
  }

  void retainWhere(bool Function(E element) test) {
    _items.retainWhere(test);
  }

  Iterable get reversed => _items.reversed;

  void setAll(int index, Iterable<E> iterable) {
    _items.setAll(index, iterable);
  }

  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    _items.setRange(start, end, iterable, skipCount);
  }

  void shuffle([Random? random]) {
    _items.shuffle(random);
  }

  get single => _items.single;

  singleWhere(bool Function(E element) test, {Function()? orElse}) {
    return _items.singleWhere(test);
  }

  Iterable skip(int count) {
    return _items.skip(count);
  }

  Iterable skipWhile(bool Function(E value) test) {
    return _items.skipWhile(test);
  }

  void sort([int Function(E a, E b)? compare]) {
    _items.sort(compare);
  }

  List sublist(int start, [int? end]) {
    return _items.sublist(start, end);
  }

  Array subarray(int start, [int? end]) {
    List newList = sublist(start, end);
    return Array.fromList(newList);
  }

  Iterable take(int count) {
    return _items.take(count);
  }

  Iterable takeWhile(bool Function(E value) test) {
    return _items.takeWhile(test);
  }

  List toList({bool growable = true}) {
    return _items.toList(growable: growable);
  }

  Set toSet() {
    return _items.toSet();
  }

  Iterable where(bool Function(E element) test) {
    return _items.where(test);
  }

  Iterable<T> whereType<T>() {
    return _items.whereType<T>();
  }

  String toString() {
    return _items.toString();
  }
}
