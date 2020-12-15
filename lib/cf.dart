library flutter_cresenity;

import 'package:flutter/cupertino.dart';
import 'package:flutter_cresenity/app/api/api_manager.dart';
import 'package:flutter_cresenity/app/model/model_bootstrap.dart';
import 'package:flutter_cresenity/bloc/bloc_manager.dart';
import 'package:flutter_cresenity/config/config.dart';
import 'package:flutter_cresenity/exception/exception_bootstrap.dart';
import 'package:flutter_cresenity/exception/exception_manager.dart';
import 'package:flutter_cresenity/http/http.dart';
import 'package:flutter_cresenity/interface/bootable.dart';
import 'package:flutter_cresenity/router/navigator_manager.dart';
import 'package:flutter_cresenity/storage/storage.dart';
import 'package:flutter_cresenity/storage/storage_bootstrap.dart';
import 'package:flutter_cresenity/translation/translation_manager.dart';
import 'package:flutter_cresenity/translation/translator.dart';
import 'package:flutter_cresenity/validation/validator_bootstrap.dart';
import 'package:flutter_cresenity/app/model/model_factory.dart';

class CF {
  static bool _inited = false;

  static BlocManager get bloc => BlocManager.instance();
  static Http get http => Http.instance();
  static NavigatorManager get navigator => NavigatorManager.instance();

  static Storage get storage => Storage.instance();

  static Translator get translator => TranslationManager.instance().translator;
  static TranslationManager get translation => TranslationManager.instance();

  static ModelFactory get model => ModelFactory.instance();
  static ExceptionManager get exception => ExceptionManager.instance();

  static ApiManager get api => ApiManager.instance();

  static Future<void> init([Function(Config) setupCallback]) async {
    if (_inited) {
      return;
    }
    WidgetsFlutterBinding.ensureInitialized();
    if (setupCallback != null) {
      setupCallback(Config.instance());
    }
    _inited = true;
    List<Bootable> bootstrapper = List();

    bootstrapper.add(ValidatorBootstrap());
    bootstrapper.add(StorageBootstrap());
    bootstrapper.add(ModelBootstrap());
    bootstrapper.add(ExceptionBootstrap());

    for (int i = 0; i < bootstrapper.length; i++) {
      await bootstrapper[i].boot();
    }
  }
}
