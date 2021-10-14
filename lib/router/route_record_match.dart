

import 'package:flutter_cresenity/router/route_record.dart';

/// A matched [AppRoute]
class RouteRecordMatch {
  // constructors
  RouteRecordMatch(this.route);

  // properties
  RouteRecord route;
  Map<String, List<String>> parameters = <String, List<String>>{};
}