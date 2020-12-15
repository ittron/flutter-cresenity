import 'package:flutter/widgets.dart';

class Navigator {
  Navigator._();
  static final Navigator _instance = new Navigator._();
  final GlobalKey<NavigatorState> _navigatorKey =
      new GlobalKey<NavigatorState>();

  factory Navigator.instance() {
    return _instance;
  }

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<dynamic> navigateTo(String routeName) {
    return _navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> replaceTo(String routeName) {
    return _navigatorKey.currentState.pushReplacementNamed(routeName);
  }
}
