import 'package:flutter/cupertino.dart';
import 'package:flutter_cresenity/router/type.dart';

/// A route that is added to the router tree.
class RouteRecord {
  String route;
  dynamic handler;
  TransitionType? transitionType;
  Duration? transitionDuration;
  RouteTransitionsBuilder? transitionBuilder;
  RouteRecord(this.route, this.handler,
      {this.transitionType, this.transitionDuration, this.transitionBuilder});
}
