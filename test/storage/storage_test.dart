



import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await CF.init();
  test("Storage test", (){
    CF.storage.put("testing", "test");
    expect(CF.storage.get("testing"), "test");
    expect(CF.storage.get("unset"), null);
  });

}