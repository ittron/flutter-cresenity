import 'package:example/screen/home_screen.dart';
import 'package:example/screen/ui/card_screen.dart';
import 'package:example/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cresenity/cf.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cresenity Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: UIData.themeData(),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/ui/card': (context) => CardScreen(),
      },
      navigatorKey: CF.navigator.navigatorKey,
    );
  }
}
