import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iruri/model/member.dart';
import 'package:iruri/util/interface.dart';

class UserAPI {
  final baseURL = serverURL + "user/";

  Future<void> postNewUserInfo(Member data) async {
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

  Future<void> updateUserInfo(Member data) async {
    final res =
        await http.patch(Uri.parse(baseURL), body: jsonEncode(data.toJson()));
    if (res.statusCode == 200)
      print('User Info Updated');
    else
      throw Exception('User Info Update Error\n>' + res.body.toString());
  }
  
  Future<List<User>> findAll() async {
    final res = await http.get(baseURL);
    if (res.statusCode == 200) {
      final parsedJson = json.decode(res.body)['result'] as List;
      final list = parsedJson.map((json) => User.fromJson(json)).toList();
      return list;
    } else {
      throw Exception(res.body.toString());
    }
  }
  
  Future<User> findbyId(String id) async {
    final res = await http.get(baseURL);
    if (res.statusCode == 200) {
      final parsedJson = json.decode(res.body)['result'] as List;
      print('finbyid');
      print(parsedJson);
      final list = parsedJson.map((json) => User.fromJson(json)).toList();
      print(list.toString());
      for(int i = 0; i < list.length; i++){
        if(list[i].sId == '609bc2d60dd8c13d95a81073')
          return list[i];
      }
    } else {
      throw Exception(res.body.toString());
    }
  }
}