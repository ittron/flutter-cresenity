import 'package:flutter_cresenity/support/collection.dart';

import 'file_collection.dart';
import 'param_collection.dart';

class Request {
  String url;
  String method;
  Object data;
  String dataType;
  ParamCollection _paramCollection;
  FileCollection _fileCollection;

  Request({String url, String method = 'GET', dynamic data, String dataType = 'text', dynamic files}) {
    this.url = url;
    this.method = method;
    this.data = data;
    _paramCollection = ParamCollection(items: Collection(data));
    this.dataType = dataType;
    this._fileCollection = FileCollection(items:Collection(files));

  }

  get paramCollection => _paramCollection;
  get fileCollection => _fileCollection;





}
