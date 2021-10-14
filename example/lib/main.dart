import 'dart:async';

import 'package:example/app.dart';
import 'package:example/module/base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cresenity/cf.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    await Base.init();
    FlutterError.onError = (FlutterErrorDetails details) async {
      CF.exception
          .reportError(details.exception, details.stack, errorDetails: details);
    };
    WidgetsFlutterBinding.ensureInitialized();
    runApp(App());
  }, (dynamic error, StackTrace stackTrace) {
    CF.exception.reportError(error, stackTrace);
  });
}
