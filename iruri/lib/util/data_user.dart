import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:iruri/model/user.dart';
import 'package:iruri/util/interface.dart';
// package
import 'package:file_picker/file_picker.dart';

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

  /** [findUserById] find user information by uid */
  Future<User> findUserById(String id) async {
    final res = await http.get(Uri.parse(baseURL + "/" + id));
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.body.toString());
    }
  }

  Future<User> signIn(String id, String pw) async {
    final info = {"id": id, "pw": pw};
    final headers = {"Content-type": "application/json"};
    final res = await http.post(Uri.parse(baseURL + "sign-in/"),
        headers: headers, body: jsonEncode((info)));
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body)['result']);
    } else {
      print(res.body.toString());
      throw Exception('wrong information');
    }
  }

  /// [updateUserInfo] using future make second step
  /// first step upload [upload-user-portfolio/:id]
  /// second step upload profile image with other texts [/:id]
  /// used params [User user, File profileImage, PlatformFile portfolio]
  Future<void> updateUserProfile(
      User user, File profileImage, PlatformFile portfolio) async {
    final uid = user.uid;
    var fileRequest, imageRequest;
    if (portfolio != null) {
      /// #1 Portfolio Upload
      /// first step upload portfolio using [MultipartRequest]
      fileRequest = http.MultipartRequest(
          "PATCH", Uri.parse(baseURL + 'upload-user-portfolio/' + uid));
      // multipart
      var fileMultipart = await http.MultipartFile.fromPath(
          "file", portfolio.path,
          contentType: MediaType('multipart', 'formed-data'));
      // add file to multipart
      fileRequest.files.add(fileMultipart);
    }

    /// #2 Profile Image and other texts upload
    /// second step upload Image using [MultipartReqeust]
    /// File from path and fields needs to be added
    imageRequest = http.MultipartRequest("PATCH", Uri.parse(baseURL + uid));
    var imageMultipart = await http.MultipartFile.fromPath(
        'file', profileImage.path,
        contentType: MediaType('image', 'png'));
    // add file to multipart
    imageRequest.files.add(imageMultipart);

    /// [User] fill the fields
    /// we only update [nickname, phoneNumber, career, desc, roles, genres] for text
    /// List<String> objects needs to be wrapped up by [jsonEncode]
    imageRequest.fields['info[roles]'] = jsonEncode(user.profileInfo.roles);
    imageRequest.fields['info[genres]'] = jsonEncode(user.profileInfo.genres);
    imageRequest.fields['info[nickname]'] = user.profileInfo.nickname;
    imageRequest.fields['info[phoneNumber]'] = user.profileInfo.phoneNumber;
    imageRequest.fields['info[desc]'] = user.profileInfo.desc;
    imageRequest.fields['info[career]'] = user.profileInfo.career;
    // add content-type about fields
    imageRequest.headers['Content-Type'] = 'application/json';

    /// #3 Send request to server one-by-one
    /// use callback [then()] to process the task
    /// check portfolio is null
    var response;
    if (portfolio != null) {
      response = await fileRequest.send().then((value) => imageRequest.send());
    } else {
      response = await imageRequest.send();
    }
    // listen for response
    response.stream.transform(utf8.decoder).listen((event) {
      print(event);
    });
  }
}
