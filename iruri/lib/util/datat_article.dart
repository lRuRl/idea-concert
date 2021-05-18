import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// files
import 'package:iruri/model/article.dart';
import 'package:iruri/util/interface.dart';

// articles
class ArticleAPI {
  final baseURL = serverURL + "articles/";

  // GET - ONE(ID)
  Future<Article> findById(String id) async {
    final res = await http.get(baseURL + id);

    if (res.statusCode == 200) {
      return Article.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.body.toString());
    }
  }

  // GET - ALL
  Future<List<Article>> findAll() async {
    final res = await http.get(baseURL);

    if (res.statusCode == 200) {
      final parsedJson = json.decode(res.body)['result'] as List;
      final list = parsedJson.map((json) => Article.fromJson(json)).toList();
      return list;
    } else {
      throw Exception(res.body.toString());
    }
  }

  // POST
  Future<void> post(Article data) async {
    final res = await http.post(baseURL, body: data.toJson());

    if (res.statusCode == 200)
      print('new article uploaded!');
    else
      throw Exception('article upload error \n>' + res.body.toString());
  }

  // PATCH
  Future<void> update(Article data) async {
    final res = await http.patch(baseURL, body: data.toJson());

    if (res.statusCode == 200)
      print('article updated');
    else
      throw Exception('article update error\n>' + res.body.toString());
  }

  // DELETE
  Future<void> delete(String id) async {
    // TODO: check user
    final res = await http.delete(baseURL);

    if (res.statusCode == 200)
      print('article deleted');
    else
      throw Exception('article delete error\n>' + res.body.toString());
  }
}
