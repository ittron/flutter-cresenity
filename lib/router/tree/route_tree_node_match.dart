import 'package:flutter_cresenity/router/tree/route_tree_node.dart';

/// A matched [RouteTreeNode]
class RouteTreeNodeMatch {
  // constructors
  RouteTreeNodeMatch(this.node);

  RouteTreeNodeMatch.fromMatch(RouteTreeNodeMatch? match, this.node) {
    parameters = <String, List<String>>{};
    if (match != null) {
      parameters.addAll(match.parameters);
    }
  }

  // properties
  RouteTreeNode node;
  Map<String, List<String>> parameters = <String, List<String>>{};
}
