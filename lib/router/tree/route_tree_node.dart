import 'package:flutter_cresenity/router/route_record.dart';
import 'package:flutter_cresenity/router/type.dart';

/// A node on [RouteTree]
class RouteTreeNode {
  // properties
  String part = '';
  RouteTreeNodeType? type;
  List<RouteRecord> routes = <RouteRecord>[];
  List<RouteTreeNode> nodes = <RouteTreeNode>[];
  RouteTreeNode? parent;

  // constructors
  RouteTreeNode(this.part, this.type);

  bool isParameter() {
    return type == RouteTreeNodeType.parameter;
  }
}
