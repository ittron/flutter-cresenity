import 'package:flutter_cresenity/mixin/interacts_with_time.dart';
import 'package:flutter_test/flutter_test.dart';

class DummyClass with InteractsWithTime {}

void main() {
  test("test secondUntil", () {
    DummyClass cls = DummyClass();
    Duration duration = Duration(hours: 1);

    expect(cls.secondUntil(duration), 60 * 60);

    expect(cls.secondUntil(DateTime.now().add(duration)), 60 * 60);
  });
}
