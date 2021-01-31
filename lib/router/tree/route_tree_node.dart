



import 'package:flutter_cresenity/router/route_record.dart';
import 'package:flutter_cresenity/router/type.dart';

/// A node on [RouteTree]
class RouteTreeNode {
  // constructors
  RouteTreeNode(this.part, this.type);

  // properties
  String part;
  RouteTreeNodeType type;
  List<RouteRecord> routes = <RouteRecord>[];
  List<RouteTreeNode> nodes = <RouteTreeNode>[];
  RouteTreeNode parent;

  bool isParameter() {
    return type == RouteTreeNodeType.parameter;
  }
}