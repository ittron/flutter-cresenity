


import 'package:flutter_cresenity/helper/hash.dart';

class Tuple<T1,T2> {
  final T1 item1;
  final T2 item2;

  const Tuple(this.item1,this.item2);

  factory Tuple.fromList(List items) {
    return Tuple<T1, T2>(items[0] as T1, items[1] as T2);
  }

  /// Returns a tuple with the first item set to the specified value.
  Tuple<T1, T2> withItem1(T1 v) => Tuple<T1, T2>(v, item2);

  /// Returns a tuple with the second item set to the specified value.
  Tuple<T1, T2> withItem2(T2 v) => Tuple<T1, T2>(item1, v);

  /// Creates a [List] containing the items of this [Tuple2].
  ///
  /// The elements are in item order. The list is variable-length
  /// if [growable] is true.
  List toList({bool growable = false}) =>
      List.from([item1, item2], growable: growable);

  @override
  String toString() => '[$item1, $item2]';

  @override
  bool operator ==(Object other) =>
      other is Tuple && other.item1 == item1 && other.item2 == item2;

  @override
  int get hashCode => Hash.hash2(item1.hashCode, item2.hashCode);
}