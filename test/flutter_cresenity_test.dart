import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/http/http.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test CF', () {
    expect(CF.http.adapterType == Http.ADAPTER_HTTP, true);
  });
}
