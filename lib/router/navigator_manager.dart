import 'package:flutter/widgets.dart';

class NavigatorManager {
  NavigatorManager._();
  static final NavigatorManager _instance = new NavigatorManager._();
  final GlobalKey<NavigatorState> _navigatorKey =
      new GlobalKey<NavigatorState>();

  factory NavigatorManager.instance() {
    return _instance;
  }

  BuildContext get context => _navigatorKey.currentState?.overlay?.context;

  bool hasValidContext() {
    return context != null;
  }

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<dynamic> navigateTo(String routeName) {
    return _navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> replaceTo(String routeName) {
    return _navigatorKey.currentState.pushReplacementNamed(routeName);
  }
}
