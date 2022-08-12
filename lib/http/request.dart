import 'package:flutter_cresenity/support/collection.dart';

import 'file_collection.dart';
import 'param_collection.dart';

class Request {
  String url;
  String method = 'GET';
  dynamic data;
  String dataType = 'text';
  ParamCollection? _paramCollection;
  FileCollection? _fileCollection;

  Request(
      {required this.url,
      this.method = 'GET',
      this.data,
      this.dataType = 'text',
      dynamic files}) {
    this._paramCollection = ParamCollection(items: Collection(data));
    this._fileCollection = FileCollection(items: Collection(files));
  }

  get paramCollection => _paramCollection;
  get fileCollection => _fileCollection;
}
