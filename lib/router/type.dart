import 'package:flutter/material.dart';

/// A [RouteTreeNode] type
enum RouteTreeNodeType {
  component,
  parameter,
}

/// The type of transition to use when pushing/popping a route.
///
/// [TransitionType.custom] must also provide a transition when used.
enum TransitionType {
  native,
  nativeModal,
  inFromLeft,
  inFromTop,
  inFromRight,
  inFromBottom,
  fadeIn,
  custom,
  material,
  materialFullScreenDialog,
  cupertino,
  cupertinoFullScreenDialog,
  none,
}

/// The match type of the route.
enum RouteMatchType {
  visual,
  nonVisual,
  noMatch,
}

/// The type of the handler, whether it's a buildable route or
/// a function that is called when routed.
enum HandlerType {
  route,
  function,
}

/// Builds out a screen based on string path [parameters] and context.
///
/// Note: you can access [RouteSettings] with the [context.settings] extension
typedef Widget HandlerFunc(
    BuildContext context, Map<String, List<String>>? parameters);

/// A function that creates new routes.
typedef Route<T> RouteCreator<T>(
    RouteSettings route, Map<String, List<String>>? parameters);
