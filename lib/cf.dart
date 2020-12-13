library flutter_cresenity;

import 'package:flutter_cresenity/bloc/bloc_manager.dart';
import 'package:flutter_cresenity/http/http.dart';
import 'package:flutter_cresenity/interface/bootable.dart';
import 'package:flutter_cresenity/router/navigator.dart';
import 'package:flutter_cresenity/translation/translation_manager.dart';
import 'package:flutter_cresenity/translation/translator.dart';
import 'package:flutter_cresenity/validation/validator_bootstrap.dart';

class CF {

  static BlocManager get bloc => BlocManager.instance();
  static Http get http => Http.instance();
  static Navigator get navigator => Navigator.instance();


  static Translator get translator => TranslationManager.instance().translator;
  static TranslationManager get translation => TranslationManager.instance();


  static init() {
    List<Bootable> bootstrapper= List();

    bootstrapper.add(ValidatorBootstrap());


    bootstrapper.forEach((element) {
      element.boot();
    });

  }
}

