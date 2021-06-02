import 'dart:convert';

// article
import 'package:iruri/model/article.dart';

class User {
  String id;
  String pw;
  String uid;
  String image;
  String imageChunk;
  String portfolio;
  String portfolioChunk;
  ProfileInfo profileInfo;
  bool hasSigned;

  User(
      {this.hasSigned,
      this.id,
      this.image,
      this.imageChunk,
      this.portfolio,
      this.portfolioChunk,
      this.profileInfo,
      this.pw,
      this.uid});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      pw: json['pw'],
      uid: json['_id'],
      image: json['image'],
      imageChunk: json['imageChunk'],      
      portfolio: json['portfolio'],
      portfolioChunk: json['portfolioChunk'],
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

  List<String> getApplyRoles(Article article) {
    var applicant = article.detail.applicant;
    List<String> result = [];
    if (applicant.drawAfters?.isEmpty == false) {
      for (int i = 0; i < applicant.drawAfters.length; i++) {
        if (applicant.drawAfters[i].uid == this.uid) {
          result.add('후보정');
        }
      }
    }

    if (applicant.drawColors?.isEmpty == false) {
      for (int i = 0; i < applicant.drawColors.length; i++) {
        if (applicant.drawColors[i].uid == this.uid) {
          result.add('채색');
        }
      }
    }
    if (applicant.drawChars?.isEmpty == false) {
      for (int i = 0; i < applicant.drawChars.length; i++) {
        if (applicant.drawChars[i].uid == this.uid) {
          result.add('캐릭터');
        }
      }
    }

    if (applicant.drawLines?.isEmpty == false) {
      for (int i = 0; i < applicant.drawLines.length; i++) {
        if (applicant.drawLines[i].uid == this.uid) {
          result.add('선화');
        }
      }
    }

    if (applicant.drawDessins?.isEmpty == false) {
      for (int i = 0; i < applicant.drawDessins.length; i++) {
        if (applicant.drawDessins[i].uid == this.uid) {
          result.add('그림뎃생');
        }
      }
    }

    if (applicant.drawContis?.isEmpty == false) {
      for (int i = 0; i < applicant.drawContis.length; i++) {
        if (applicant.drawContis[i].uid == this.uid) {
          result.add('그림콘티');
        }
      }
    }

    if (applicant.drawMains?.isEmpty == false) {
      for (int i = 0; i < applicant.drawMains.length; i++) {
        if (applicant.drawMains[i].uid == this.uid) {
          result.add('메인그림');
        }
      }
    }

    if (applicant.writeContis?.isEmpty == false) {
      for (int i = 0; i < applicant.writeContis.length; i++) {
        if (applicant.writeContis[i].uid == this.uid) {
          result.add('글콘티');
        }
      }
    }

    if (applicant.writeMains?.isEmpty == false) {
      for (int i = 0; i < applicant.writeMains.length; i++) {
        if (applicant.writeMains[i].uid == this.uid) {
          result.add('메인글');
        }
      }
    }

    return result;
  }
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
