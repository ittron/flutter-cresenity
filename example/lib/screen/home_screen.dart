// ignore: must_be_immutable
import 'package:example/model/get_info_model.dart';
import 'package:example/module/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cresenity/bloc/bloc.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/http/response.dart';
import 'dart:developer' as logger;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Bloc<GetInfoModel> getInfoBloc = CF.bloc.createBloc<GetInfoModel>();

  @override
  void initState() {
    super.initState();
    _doGetInfo();
  }

  void _doGetInfo() async {
    Response response = await Base.api.run('GetInfo');
    if (response != null) {
      logger.log(response.toString());
      GetInfoModel model = response.toDataModel<GetInfoModel>();
      getInfoBloc.setValue(model);
    }
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
        title: Text('Flutter Cresenity Demo'),
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
              'Your Ip Address:',
            ),
            Container(
              height: 50,
              child:
                  getInfoBloc.createBuilder((BuildContext context, snapshot) {
                String ipAddress = snapshot.data?.value?.ipAddress;
                if (ipAddress == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Text(
                  ipAddress,
                  style: Theme.of(context).textTheme.headline4,
                );
              }),
            ),
            RaisedButton(
              onPressed: () async {
                //CF.navigator.navigateTo("/ui/card");
                //NavigationService nav = new NavigationService();
                //nav.navigateTo("newScreen");
                getInfoBloc.setValue(null);

                //await Future.delayed(Duration(seconds: 3));
                _doGetInfo();
              },
              child: Text("Get Ip Address"),
            ),
            RaisedButton(
              onPressed: () async {
                await Base.api.toDataModel<GetInfoModel>().run("NotFound");
              },
              child: Text("Api Error"),
            )
          ],
        ),
      ),
    );
  }
}
