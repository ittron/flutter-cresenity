import 'package:flutter/material.dart';
import 'package:flutter_cresenity/bloc/bloc_result.dart';

import 'bloc.dart';

class BlocBuilder<T> extends StatefulWidget {
  final Function builder;
  final Stream<BlocResult<T>?>? stream;
  final Function? init;
  final Bloc? bloc;

  BlocBuilder({
    Key? key,
    required this.builder,
    this.stream,
    this.init,
    this.bloc,
  }) : super(key: key);

  @override
  _BlocBuilderState<T> createState() => _BlocBuilderState<T>();
}

class _BlocBuilderState<T> extends State<BlocBuilder<T>> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocResult<T>?>(
        stream: widget.stream,
        builder:
            (BuildContext context, AsyncSnapshot<BlocResult<T>?> snapshot) {
          return widget.builder(context, snapshot);
        });
  }
}
