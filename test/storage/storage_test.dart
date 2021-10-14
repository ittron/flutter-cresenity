import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await CF.init();
  test("Storage test", () async {
    CF.storage.put("testing", "test");
    expect(CF.storage.get("testing"), "test");
    expect(CF.storage.get("unset"), null);

    await CF.storage.put("testing_await", "await");
    expect(CF.storage.get("testing_await"), "await");
  });
}
