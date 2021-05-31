import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iruri/model/profile_info.dart';
import 'package:iruri/util/interface.dart';

class UserAPI {
  final baseURL = serverURL + "user/";

  get data => null;

  Future<void> postNewUserInfo(User data) async {
    final response = await http.post(Uri.parse(baseURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      print("success");
    } else
      throw Exception('User Info post error\n>' + response.body.toString());
  }

  Future<void> updateUserInfo(User data) async {
    final res =
        await http.patch(Uri.parse(baseURL), body: jsonEncode(data.toJson()));
    if (res.statusCode == 200)
      print('User Info Updated');
    else
      throw Exception('User Info Update Error\n>' + res.body.toString());
  }

  Future<List<User>> findAll() async {
    final res = await http.get(Uri.parse(baseURL));
    if (res.statusCode == 200) {
      final parsedJson = json.decode(res.body)['result'] as List;
      final list = parsedJson.map((json) => User.fromJson(json)).toList();
      return list;
    } else {
      throw Exception(res.body.toString());
    }
  }

  Future<User> findbyId(String id) async {
    final res = await http.get(Uri.parse(baseURL));
    if (res.statusCode == 200) {
      final parsedJson = json.decode(res.body)['result'] as List;
      print('finbyid');
      print(parsedJson);
      final list = parsedJson.map((json) => User.fromJson(json)).toList();
      print(list.toString());

      for (int i = 0; i < list.length; i++) {
        if (list[i].uid == '609bc2d60dd8c13d95a81073') //임시로 놓은 id
          return list[i];
      }
    } else {
      throw Exception(res.body.toString());
    }
  }

  Future<bool> signIn(BuildContext context, String id, String pw) async {
    final info = {"id": id, "pw": pw};
    final headers = {"Content-type": "application/json"};
    final res = await http.post(Uri.parse(baseURL + "sign-in/"),
        headers: headers, body: jsonEncode((info)));
    if (res.statusCode == 200) {
      return true;
    } else {
      print(res.body.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('잘못 입력하셨습니다.')));
      return false;
    }
  }
}
