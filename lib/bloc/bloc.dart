import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cresenity/bloc/bloc_builder.dart';
import 'package:flutter_cresenity/bloc/bloc_result.dart';

class Bloc<T> {
  // ignore: close_sinks
  StreamController<BlocResult<T>> actionController =
      StreamController.broadcast();

  Stream<BlocResult<T>> get stream => actionController.stream;

  BlocResult<T> result;
  bool _isDispatching = false;
  bool asyncDispatching = false;

  get isDispatching => _isDispatching;

  void setValue(T t, {String state}) {
    BlocResult<T> blocResult = BlocResult<T>(t, state);

    actionController.sink.add(blocResult);
  }

  bool dispatch([Function callback]) {
    if (!asyncDispatching && isDispatching) {
      return false;
    }
    if (callback == null) {
      actionController.sink.add(null);
      return true;
    }
    _isDispatching = true;
    Stream stateString = callback(result);

    stateString.listen((item) {
      BlocResult<T> result = BlocResult<T>.fromDynamic(item);
      actionController.sink.add(result);
    }, onDone: () {
      _isDispatching = false;
    });
    return true;
  }

  BlocBuilder<T> createBuilder(
      Function(BuildContext, AsyncSnapshot<BlocResult<T>>) callback) {
    return BlocBuilder<T>(
      stream: actionController.stream,
      builder: callback,
      bloc: this,
    );
  }
}
