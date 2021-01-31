import 'package:flutter/material.dart';

class AutoCloseKeyboardWidget extends StatelessWidget {
  final Widget child;

  const AutoCloseKeyboardWidget({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}