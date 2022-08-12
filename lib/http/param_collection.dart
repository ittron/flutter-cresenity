import '../support/caster.dart';
import '../support/collection.dart';

class ParamCollection extends Collection {
  ParamCollection({dynamic items}) : super(items);

  String asPostString() {
    String result = '';

    Map<String, String> map = asPostStringMap();
    map.forEach((key, value) {
      result += '&' + key + '=' + value;
    });

    if (result.length > 0) {
      result = result.substring(1);
    }

    return result;
  }

  Map<String, String> asPostStringMap({String prefix = ''}) {
    Map<String, String> map = {};

    all().forEach((key, value) {
      Caster casterValue = Caster(value);
      if (!casterValue.isScalar()) {
        String keyPrefix = prefix.length > 0 ? prefix + '[' + key + ']' : key;
        ParamCollection paramCollection = ParamCollection(items: value);
        map.addAll(paramCollection.asPostStringMap(prefix: keyPrefix));
      } else {
        map[key] = casterValue.toString();
      }
    });
    return map;
  }
}
