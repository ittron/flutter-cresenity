import 'package:flutter/material.dart';

import 'bloc.dart';
import 'bloc_builder_result.dart';
import 'bloc_state.dart';

class BlocBuilder extends StatefulWidget {
  final Function builder;
  final Stream stream;
  final Function init;
  final Bloc bloc;

  BlocBuilder({
    Key key,
    this.builder,
    this.stream,
    this.init,
    this.bloc,
  }) : super(key: key);

  @override
  _BlocBuilderState createState() => _BlocBuilderState();
}

class _BlocBuilderState extends State<BlocBuilder> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.stream,
        builder: (context, snapshot) {
          BlocState blocState = widget.bloc != null ? widget.bloc.state : null;
          if (snapshot.data != null) {
            blocState = snapshot.data;
          }

          BlocBuilderResult builderResult =
              BlocBuilderResult(context, blocState);
          return widget.builder(builderResult);
        });
  }
}
