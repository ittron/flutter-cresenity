



import 'dart:collection';

import 'package:flutter_cresenity/helper/str.dart';
import 'package:flutter_cresenity/translation/translation_manager.dart';
import 'package:flutter_cresenity/translation/repository.dart';
import 'package:flutter_cresenity/support/collection.dart';


class Translator  {

  String _locale;

  Repository _repository;

  Translator(this._locale, this._repository);
  Repository get repository => _repository;
  Repository get fallbackRepository => TranslationManager.instance().fallbackRepository;


  get(key , [replace]) {
    Collection replacement = Collection(replace);
    var a = repository.data[key];

    var line = repository.data[key];

    if(line==null) {
      line = fallbackRepository.data[key];
    }

    if(line!=null) {
      return line;
    }
    // If the line doesn't exist, we will return back the key which was requested as
    // that will be quick to spot in the UI if language keys are wrong or missing
    // from the application's language files. Otherwise we can return the line.
    if(line==null) {
      line = key;
    }

    return _makeReplacements(line,replacement);


  }



  ///Make the place-holder replacements on a line.

  _makeReplacements(line, Collection replace) {
    if(replace.isEmpty) {
      return line;
    }

    replace = _sortReplacements(replace);

    replace.forEach((key, value) {
      line = Str.replace([":" + key,":"+Str.upper(key) , ":" + Str.ucfirst(key)],
          [value,Str.upper(value) , Str.ucfirst(value)], line);

    });


    return line;
  }


  ///Sort the replacements array.
  Collection _sortReplacements(Collection replace) {
    return replace.sortBy((String key,value) {
      return key.length * -1;
    });
  }
}








