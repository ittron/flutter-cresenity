library flutter_cresenity;

import 'package:flutter_cresenity/bloc/bloc_manager.dart';
import 'package:flutter_cresenity/http/http.dart';

class CF {

  static BlocManager get bloc => BlocManager();
  static Http get http => Http();
}