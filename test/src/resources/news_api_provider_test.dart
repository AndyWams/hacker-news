import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';

void main() {
  test('Fetch top ids returns a list of ids', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('Fetch a single item return an item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMAP = {'id': 123};
      return Response(json.encode(jsonMAP), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}
