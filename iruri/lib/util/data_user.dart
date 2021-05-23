import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// files
import 'package:iruri/model/article.dart';
import 'package:iruri/util/interface.dart';
import 'package:iruri/model/profile_info.dart';

// user
class UserAPI {
  //final baseURL = serverURL + "user/";
  final baseURL = myURL + "user/";

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
        final list = parsedJson.map((json) => User.fromJson(json)).toList();
        for(int i = 0; i < list.length; i++){
          if(list[i].sId == id)
            return list[i];
        }
      } else {
        throw Exception(res.body.toString());
      }
    }

  Future<void> update(User data) async {
    final res = await http.patch(baseURL, body: data.toJson());

    if (res.statusCode == 200)
      print('user updated');
    else
      throw Exception('user update error\n>' + res.body.toString());
  }


  /*

  // POST
  Future<void> postNewArticle(Article data, String filePath) async {
    // create multipart Request
    var request = http.MultipartRequest("POST", Uri.parse(baseURL));
    // multipart takes file
    var multipartFile = await http.MultipartFile.fromPath("file", filePath,
        contentType: MediaType('image', 'png'));
    // add file to multipart
    request.files.add(multipartFile);
    // body
    request.fields['imagePath'] = data.imagePath;
    request.fields['memebers'] = jsonEncode(data.members);
    request.fields['contracts'] = jsonEncode(data.contracts);
    request.fields['detail[status]'] = data.detail.status;
    request.fields['detail[reportedDate]'] = data.detail.reportedDate;
    request.fields['detail[dueDate]'] = data.detail.dueDate;
    request.fields['detail[writer]'] = data.detail.writer;
    request.fields['detail[location]'] = data.detail.location;
    request.fields['detail[applicants]'] = jsonEncode(data.detail.applicants);
    request.fields['detail[peroid][from]'] = data.detail.period.from;
    request.fields['detail[peroid][to]'] = data.detail.period.to;
    request.fields['detail[condition][projectType]'] = data.detail.condition.projectType;
    request.fields['detail[condition][contractType]'] = data.detail.condition.contractType;
    request.fields['detail[condition][wage]'] = data.detail.condition.wage;
    request.fields['detail[content][title]'] = data.detail.content.title;
    request.fields['detail[content][desc]'] = data.detail.content.desc;
    request.fields['detail[content][tags]'] = jsonEncode(data.detail.content.tags);
    request.fields['detail[content][genres]'] = jsonEncode(data.detail.content.genres);
    request.fields['detail[content][prefer]'] = data.detail.content.prefer;
    // headers for body
    request.headers["Content-Type"] = "application/json";
    // send request
    var response = await request.send();

    // listen for response
    response.stream.transform(utf8.decoder).listen((event) {
      print(event);
    });
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
  }*/
}
