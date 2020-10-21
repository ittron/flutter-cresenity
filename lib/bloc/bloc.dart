import 'dart:async';

import 'package:flutter_cresenity/bloc/bloc_builder.dart';
import 'package:flutter_cresenity/bloc/bloc_result.dart';
import 'package:flutter_cresenity/bloc/bloc_state.dart';


class Bloc<E> {
  // ignore: close_sinks
  StreamController<BlocState> actionController = StreamController.broadcast();

  Stream<BlocState> get stream => actionController.stream;

  BlocResult<E> result = BlocResult<E>();
  bool _isDispatching = false;
  BlocState<E> state;
  bool asyncDispatching = false;

  get isDispatching => _isDispatching;

  void setValue(E t, {String state}) {
    result.setValue(t);
    BlocState<E> blocState = BlocState<E>(state, result, this);
    this.state = blocState;

    actionController.sink.add(blocState);
  }

  bool dispatch(Function callback) {
    if (!asyncDispatching && isDispatching) {
      return false;
    }

    _isDispatching = true;
    Stream stateString = callback(result);

    stateString.listen((item) {
      BlocState<E> state = BlocState<E>(item, result, this);
      this.state = state;
      actionController.sink.add(state);
    }, onDone: () {
      _isDispatching = false;
    });
    return true;
  }

  BlocBuilder createBuilder(Function callback) {
    return BlocBuilder(
      stream: actionController.stream,
      builder: callback,
      bloc: this,
    );
  }
}
