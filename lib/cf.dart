library flutter_cresenity;

import 'package:flutter_cresenity/bloc/bloc_manager.dart';
import 'package:flutter_cresenity/http/http.dart';
import 'package:flutter_cresenity/router/navigator.dart';

class CF {

  static BlocManager get bloc => BlocManager.instance();
  static Http get http => Http.instance();
  static Navigator get navigator => Navigator.instance();
}