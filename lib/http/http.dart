import '../support/collection.dart';
import 'adapter.dart';
import 'factory.dart';
import 'request.dart';
import 'response.dart';

class Http {
  static const String ADAPTER_HTTP = 'http';

  Http._();
  static final Http _instance = new Http._();

  String _adapterType = ADAPTER_HTTP;
  factory Http() {
    return _instance;
  }

  get adapterType => _adapterType;

  void setAdapterType(String type) {
    this._adapterType = type;
  }

  Adapter _adapter() {
    return Factory.createAdapter(adapterType);

  }


  Future<Response> waitRequest({
    String url,
    Collection data,
    Collection files,
    String method = 'GET',
    String dataType = 'text',
  }) {



    Request request = Request(url:url, method:method,data:data,files:files,dataType: dataType);



    return this._adapter().request(request);
  }

  void request({
    String url,
    Collection data,
    String method = 'GET',
    String dataType = 'text',
    Function onSuccess,
    Function onError,
    Function onCompleted,
  }) async {


    Response response = await this.waitRequest(url:url,method: method,data:data,dataType: dataType);

    if(response.statusCode==200) {
      if(onSuccess!=null) {
        onSuccess(response);
      }
    } else {
      if(onError!=null) {
        onError(response);
      }
    }

    if(onCompleted!=null) {
      onCompleted(response);
    }


  }


}
