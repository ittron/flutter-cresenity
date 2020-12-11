import 'file_collection.dart';
import 'param_collection.dart';

class Request {
  String url;
  String method;
  Object data;
  String dataType;
  ParamCollection _paramCollection;
  FileCollection _fileCollection;

  Request({String url, String method = 'GET', Object data, String dataType = 'text', Object files}) {
    this.url = url;
    this.method = method;
    this.data = data;
    _paramCollection = ParamCollection(items:data);
    this.dataType = dataType;
    this._fileCollection = FileCollection(items:files);

  }

  get paramCollection => _paramCollection;
  get fileCollection => _fileCollection;





}
