import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// files
import 'package:iruri/model/article.dart';
import 'package:iruri/util/interface.dart';
import 'package:iruri/model/profile_info.dart';

// user
class UserAPI {
  final baseURL = serverURL + "user/";
  //final baseURL = myURL + "user/";

  // GET - ALL
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
  // GET - ONE(ID)
  Future<User> findbyId(String id) async {
    final res = await http.get(baseURL);
    if (res.statusCode == 200) {
      final parsedJson = json.decode(res.body)['result'] as List;
      print('finbyid');
      print(parsedJson);
      final list = parsedJson.map((json) => User.fromJson(json)).toList();
      print(list.toString());

      for(int i = 0; i < list.length; i++){
        if(list[i].sId == '609bc2d60dd8c13d95a81073') //임시로 놓은 id
          return list[i];
      }
    } else {
      throw Exception(res.body.toString());
    }
  }

  // POST
  Future<void> postNewArticle(User data, String filePath) async {
    // create multipart Request
    var request = http.MultipartRequest("POST", Uri.parse(baseURL));
    // multipart takes file
    var multipartFile = await http.MultipartFile.fromPath("file", filePath,
        contentType: MediaType('image', 'png'));
    // add file to multipart
    request.files.add(multipartFile);
    // body
    request.fields['roles'] = jsonEncode(data.roles);
    request.fields['sId'] = data.sId;
    request.fields['portfolio'] = data.portfolio;
    request.fields['profileInfo[programs]'] = jsonEncode(data.profileInfo.programs);
    request.fields['profileInfo[nickname]'] = data.profileInfo.nickname;
    request.fields['profileInfo[phoneNumber]'] = data.profileInfo.phoneNumber;
    request.fields['profileInfo[email]'] = data.profileInfo.email;
    request.fields['profileInfo[location]'] = data.profileInfo.location;
    request.fields['profileInfo[desc]'] = data.profileInfo.desc;
    
    // headers for body
    request.headers["Content-Type"] = "application/json";
    // send request
    var response = await request.send();

    // listen for response
    response.stream.transform(utf8.decoder).listen((event) {
      print(event);
    });
  }

  //Patch
  Future<void> update(User data) async {
    final res = await http.patch(baseURL, body: data.toJson());

    if (res.statusCode == 200)
      print('user updated');
    else
      throw Exception('user update error\n>' + res.body.toString());
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
