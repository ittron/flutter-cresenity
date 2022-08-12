import 'package:flutter_cresenity/router/type.dart';

class RouteHandler {
  RouteHandler({
    this.type = HandlerType.route,
    required this.handlerFunc,
  });

  final HandlerType type;
  final HandlerFunc handlerFunc;
}
