import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cresenity/bloc/bloc.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/config/config.dart';
import 'package:flutter_cresenity/http/response.dart';
import 'package:flutter_cresenity/support/caster.dart';
import 'package:flutter_cresenity/support/collection.dart';
import 'package:flutter_cresenity/app/model/response_model.dart';
import 'package:flutter_cresenity/app/model/pagination_data_model.dart';
import 'package:flutter_cresenity/app/model/abstract_data_model.dart';

void main() {



  runZonedGuarded<Future<void>>(() async {

    await CF.init((Config config) {
      config.exception.addDeveloperPageReporter();
    });
    FlutterError.onError = (FlutterErrorDetails details) async {
      CF.exception.reportError(details.exception, details.stack, errorDetails: details);
    };
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  }, (dynamic error, StackTrace stackTrace) {

    print("ERRRORRRRR");
    CF.exception.reportError(error, stackTrace);
  });

}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/newScreen': (context) => NewScreen(),
      },
      navigatorKey: CF.navigator.navigatorKey,
    );
  }
}

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("New Screen"),
        ),
        body: Center(
          child: Text("New Screen"),
        )
    );
  }
}


class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  int _counter = 0;

  Bloc counterBloc = CF.bloc.createBloc();



  void mockApi() async {
    Collection files = Collection();
    Collection params = Collection();
    String url = 'https://5e9180702810f4001648b99f.mockapi.io/v1/users';
    Response response = await CF.http.waitRequest(
      url: url,
      method: 'post',
      data: params,
      files: files,
    );

    print(response.body);


  }

  void _incrementCounter() {
    counterBloc.dispatch((result) async* {
      _counter++;
      print(_counter);
      await mockApi();
      yield "counterAdded";
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            counterBloc.createBuilder((builder){

              return Text(
                Caster(_counter).toString(),
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            RaisedButton(
              onPressed: () {

                throw "asd";
                CF.navigator.navigateTo("/newScreen");
                //NavigationService nav = new NavigationService();
                //nav.navigateTo("newScreen");
              },
              child: Text("New Screen"),
            )


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class PostModel extends AbstractDataModel {

  int postId;
  @override
  Map<String, dynamic > toJson() {
    return {'postId':postId};
  }

  PostModel.fromJson(Map map) {
    postId = 1;
  }

}
