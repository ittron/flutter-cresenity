library flutter_cresenity;

import 'dart:convert';

import 'package:flutter_cresenity/http/response.dart';
import 'package:flutter_cresenity/support/collection.dart';
import 'package:flutter_cresenity/support/array.dart';
import 'package:flutter_cresenity/cf.dart';

import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('One Record test', () async {
    Collection files = Collection();
    Collection params = Collection();
    String url = 'https://jsonplaceholder.typicode.com/todos/1';
    await CF.http.waitRequest(
      url: url,
      method: 'get',
      data: params,
      files: files,
    );
  });

  test('List Record test', () async {
    Collection files = Collection();
    Collection params = Collection();
    String url = 'https://jsonplaceholder.typicode.com/users';
    Response response = await CF.http.waitRequest(
      url: url,
      method: 'get',
      data: params,
      files: files,
    );

    Array users = new Array(jsonDecode(response.body));

    print(users[0]);
    expect(users[0] is Map, true);

    expect(users[11] == null, true);
  });
}
