import 'package:http/http.dart' as http;
import 'package:iruri/model/member.dart';
import 'package:iruri/util/interface.dart';

class UserAPI {
  final baseURL = serverURL + "users/";

  Future<void> postNewUserInfo(Member data) async {
    final response = await http.post(Uri.parse(baseURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: data.toJson());

    if (response.statusCode == 201) {
      print("success");
    } else
      throw Exception('User Info post error\n>' + response.body.toString());
  }

  Future<void> update(Member data) async {
    final res = await http.patch(Uri.parse(baseURL), body: data.toJson());
    if (res.statusCode == 200)
      print('User Info Updated');
    else
      throw Exception('User Info Update Error\n>' + res.body.toString());
  }
}
