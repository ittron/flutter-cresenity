import 'package:flutter/material.dart';
import 'package:flutter_cresenity/support/tuple.dart';

import '../support/array.dart';
import '../support/caster.dart';
import '../support/caster.dart';
import '../support/collection.dart';
import '../support/array.dart';
import '../support/collection.dart';
import '../support/collection.dart';
import 'c.dart';
class Arr {
  static bool accessible(array) {
    return array!=null && (array is Map || array is List);
  }

  static bool exists(array,key) {


    if(array is Map) {

      return array.containsKey(key);
    }
    if(array is List) {
      if(!key is int) {
        key = Caster(key).toInt();
      }
      return array.length>=key && key>=0;
    }


    return false;

  }

  static set(array, key, value) {
    if(key==null) {
      return array = value;
    }


    if(key is String && key.indexOf('.') > 0) {
      List keys = key.split(".");
      int i=0;

      while(keys.length>1) {
        String segment = keys[0];
        if (accessible(array) && !exists(array, segment)) {
          array[segment] = array is Map ? {} : [];
          array = array[segment];
        }
        key = keys[1];
        keys.removeAt(0);
      }

    }

    array[key] = value;

    return array;
  }

  static get(array, key,[dynamic defaultValue]) {

    if(array is Tuple) {
      if(key == 0 || key == "0" || key=="item1") {
        return array.item1;
      }
      if(key == 1 || key == "1" || key=="item2") {
        return array.item2;
      }
      array = array.toList();

    }

    if(!accessible(array) || key==null || !C.isScalar(key)) {
      return defaultValue;
    }


    if(array is Map) {

      if(array.containsKey(key)) {

        return array[key];
      }
    }

    if(array is List) {
      int keyInt = Caster(key).toInt();
      if(keyInt>=0 && keyInt<=array.length) {
        return array[keyInt];
      }
    }
    if(key is String && key.indexOf('.')>0) {

      for(var segment in key.split(".")) {


        if(accessible(array) && exists(array, segment)) {

          array = array[segment];
        } else {
          return defaultValue;
        }
      }
    } else {
      return defaultValue;
    }
    return array;

  }

  static String getString(map, key,[String defaultValue]) {

    var value = get(map,key,defaultValue);

    return Caster(value).toString();

  }


  static int getInt(map, key,[int defaultValue]) {
    var value = get(map,key,defaultValue);
    return Caster(value).toInt();
  }


  static Collection getCollection(map, key,[Collection defaultValue]) {
    var value = get(map,key,defaultValue);

    if(value!=null && (!(value is Collection))) {
      return Collection(value);
    }
    return value;
  }

  static Array getArray<T>(map, key,[Array defaultValue]) {
    var value = get(map,key,defaultValue);

    if(value!=null && (!(value is Array))) {
      return Array<T>(value);
    }
    return value;
  }

  static Map getMap(map, key,[Map defaultValue]) {
    var value = get(map,key,defaultValue);


    return value;
  }


  static Array wrap(value) {
    if(!C.isArray(value)) {
      value = [value];
    }

    return Array(value);
  }


  static Collection wrapCollection(value) {
    if(!C.isCollection(value)) {
      value = wrap(value);
    }
    return Collection(value);
  }

  static Array unique(Array arr) {
    return Array(arr.toSet());
  }

  static Collection<T> filter<T>(arr, [bool Function(String,T) callback]) {
    //        note: Takes a function as an argument, not a function's name
    //   example 1: var odd = (num) {return (num & 1);};
    //   example 1: Arr.filter({"a": 1, "b": 2, "c": 3, "d": 4, "e": 5}, odd);
    //   returns 1: {"a": 1, "c": 3, "e": 5}
    //   example 2: var even = (num) {return (!(num & 1));}
    //   example 2: Arr.filter([6, 7, 8, 9, 10, 11, 12], even);
    //   returns 2: {0: 6, 2: 8, 4: 10, 6: 12}
    //   example 3: Arr.filter({"a": 1, "b": false, "c": -1, "d": 0, "e": null, "f":'', "g":undefined});
    //   returns 3: {"a":1, "c":-1};

    Collection result = Collection();

    Collection items = Collection(arr);

    if(callback==null) {
      callback = ( k,v) {
        return Caster(v).toBool();
      };
    }

    items.forEach((key, value) {
      if(callback(key,value)) {
        result[key] = value;
      }
    });
    return result;


  }

  ///alias of filter, but callback is required
  static Collection<T> where<T>(arr, bool Function(String,T) callback) {
    return filter(arr,callback);
  }


  static first(arr, [Function callback, defaultValue]) {

    Array array = Array(arr);
    if(array.length==0) {
      return C.value(defaultValue);
    }
    if(callback==null) {
      return array[0];
    }
    for(int i=0; i<array.length; i++) {
      if(callback(i,array[i])) {
        return array[i];
      }
    }
    return C.value(defaultValue);
  }
}
