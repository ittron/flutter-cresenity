import 'http.dart';
import 'adapter.dart';
import 'adapter/http_adapter.dart';

class Factory {
  static Adapter createAdapter(adapterType) {
    Adapter? adapter;
    switch (adapterType) {
      case Http.ADAPTER_HTTP:
        adapter = HttpAdapter();
        break;
    }
    return adapter!;
  }
}
