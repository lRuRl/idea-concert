import 'package:http_parser/http_parser.dart';
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
    final res = await http.get(Uri.parse(baseURL + id));

    if (res.statusCode == 200) {
      return Article.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.body.toString());
    }
  }

  // GET - ALL
  Future<List<Article>> findAll() async {
    final res = await http.get(Uri.parse(baseURL));

    if (res.statusCode == 200) {
      final parsedJson = json.decode(res.body)['result'] as List;
      final list = parsedJson.map((json) => Article.fromJson(json)).toList();
      return list;
    } else {
      throw Exception(res.body.toString());
    }
  }

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
    // request.fields['detail[applicants]'] = jsonEncode(data.detail.applicants);
    request.fields['detail[period][from]'] = data.detail.period.from;
    request.fields['detail[period][to]'] = data.detail.period.to;
    request.fields['detail[condition][projectType]'] =
        data.detail.condition.projectType;
    request.fields['detail[condition][contractType]'] =
        data.detail.condition.contractType;
    request.fields['detail[condition][wage]'] = data.detail.condition.wage;
    request.fields['detail[content][title]'] = data.detail.content.title;
    request.fields['detail[content][desc]'] = data.detail.content.desc;
    request.fields['detail[content][tags]'] =
        jsonEncode(data.detail.content.tags);
    request.fields['detail[content][genres]'] =
        jsonEncode(data.detail.content.genres);
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
    final res = await http.patch(Uri.parse(baseURL), body: data.toJson());
    if (res.statusCode == 200)
      print('article updated');
    else
      throw Exception('article update error\n>' + res.body.toString());
  }

  // DELETE
  Future<void> delete(String id) async {
    // TODO: check user
    final res = await http.delete(Uri.parse(baseURL));

    if (res.statusCode == 200)
      print('article deleted');
    else
      throw Exception('article delete error\n>' + res.body.toString());
  }

  String convertPosition(String position) {
    Map<String, String> positiionMap = {
      "메인글": "writeMains",
      "글콘티": "writeContis",
      "메인그림": "drawMains",
      "그림콘티": "drawContis",
      "데셍": "drawDessins",
      "선화": "drawLines",
      "캐릭터": "drawChars",
      "채색": "drawColors",
      "후보정": "drawAfters"
    };
    return positiionMap[position];
  }

  // apply
  Future<void> apply(
      String articleId, List<String> position, String uid, String job) async {
    // test uid
    String testUid = "609a84c2bc084d78594849d0";
    // for test
    uid = testUid;
    // make query
    String query = '';

    /// add [position] to query
    for (int i = 0; i < position.length; ++i) {
      if (i == 0) {
        query += '?position=' + convertPosition(position[i]);
      } else {
        query += '&position=' + convertPosition(position[i]);
      }
    }

    /// add [uid] to query
    if (query.length > 0) {
      query += '&uid=' + uid;
    }

    /// add [job] to query
    if (query.length > 0) {
      query += '&job=' + job;
    }
    // http.patch
    String uri = baseURL + 'apply/' + articleId + query;
    print(uri);
    final res = await http.patch(Uri.parse(uri));
    // result
    if (res.statusCode == 200) {
      print('apply successed');
    } else {
      throw Exception('apply error\n> ' + res.body.toString());
    }
  }

  // applyStateUpdate
  // Example End Point : apply/321?position=drawMains&uid=123&job=confirm
  Future<void> applyStateUpdate(
      String articleId, List<String> position, String uid, String job) async {
    // test uid
    String testUid = "60b3dc5b154568805eea68e3";
    // for test
    if (uid == 'test') uid = testUid;
    // make query
    String query = '';
    for (int i = 0; i < position.length; i++) {
      query = '';
      print(position[i]);
      query += '?position=' + convertPosition(position[i]);

      /// add [uid] to query
      if (query.length > 0) {
        query += '&uid=' + uid;
      }

      /// add [job] to query
      if (query.length > 0) {
        query += '&job=' + job;
      }

      // http.patch
      String uri = baseURL + 'apply/' + articleId + query;
      print(uri);

      final res = await http.patch(Uri.parse(uri));
      // result
      if (res.statusCode == 200) {
        print('<$job>State Update successed');
      } else {
        throw Exception('apply error\n> ' + res.body.toString());
      }
    }
  }
}
