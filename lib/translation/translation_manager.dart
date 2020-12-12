





import 'package:flutter_cresenity/translation/repository.dart';
import 'package:flutter_cresenity/support/collection.dart';
import 'package:flutter_cresenity/translation/translator.dart';

import '../support/collection.dart';
import '../support/collection.dart';
import '../support/collection.dart';
import '../support/collection.dart';

class TranslationManager {
  String _locale = 'en_US';
  String _fallback = 'en_US';

  TranslationManager._();

  Collection<Translator> _translators = Collection<Translator>();


  static final TranslationManager _instance = new TranslationManager._();

  factory TranslationManager.instance() {
    return _instance;
  }

  Translator get translator => getTranslator(_locale);

  Repository get fallbackRepository => getRepository(_fallback);

  Repository getRepository(String locale) {

    return getTranslator(locale).repository;
  }


  loadRepository(String locale,data) {
    getRepository(locale).setData(Collection(data));
  }


  Translator getTranslator(String locale) {
    if(!_translators.containsKey(locale)) {
      _translators[locale] = new Translator(locale,Repository());
    }

    return _translators[locale];
  }






}