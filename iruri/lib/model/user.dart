import 'dart:convert';

class User {
  String id;
  String pw;
  String uid;
  String image;
  String portfolio;
  ProfileInfo profileInfo;
  bool hasSigned;

  User(
      {this.hasSigned,
      this.id,
      this.image,
      this.portfolio,
      this.profileInfo,
      this.pw,
      this.uid});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      pw: json['pw'],
      uid: json['_id'],
      image: json['image'],
      portfolio: json['portfolio'],
      hasSigned: json['hasSigned'],
      profileInfo: ProfileInfo.fromJson(json['info']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "pw": pw,
        "_id": uid,
        "image": image,
        "portfolio": portfolio,
        "hasSigned": hasSigned,
        "info": profileInfo.toJson()
      };
}

class ProfileInfo {
  String name;
  String phoneNumber;
  List<String> roles;
  String nickname;
  List<String> programs;
  String location;
  String desc;
  List<String> genres;
  String career;

  ProfileInfo(
      {this.programs,
      this.nickname,
      this.phoneNumber,
      this.location,
      this.desc,
      this.career,
      this.genres,
      this.name,
      this.roles});

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      roles: List.from(json['roles']),
      nickname: json['nickname'],
      programs: List.from(json['programs']),
      location: json['location'],
      desc: json['desc'],
      genres: List.from(json['genres']),
      career: json['career']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "roles": jsonEncode(roles),
        "nickname": nickname,
        "location": location,
        "programs": jsonEncode(programs),
        "desc": desc,
        "genres": jsonEncode(genres),
        "career": career
      };
}
