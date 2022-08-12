import 'package:flutter/widgets.dart';
import 'package:flutter_cresenity/router/type.dart';

/// The route that was matched.
class RouteMatch {
  RouteMatch(
      {this.matchType = RouteMatchType.noMatch,
      this.route,
      this.errorMessage = "Unable to match route. Please check the logs."});
  final Route<dynamic>? route;
  final RouteMatchType matchType;
  final String errorMessage;
}
