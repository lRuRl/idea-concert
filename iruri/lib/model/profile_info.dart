/*class User {
  String message;
  List<Result> result;

  User({this.message, this.result});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}*/

class User {
  List<String> roles;
  String sId;
  Null portfolio;
  ProfileInfo profileInfo;
  int iV;

  User({this.roles, this.sId, this.portfolio, this.profileInfo, this.iV});

  User.fromJson(Map<String, dynamic> json) {
    roles = json['roles'].cast<String>();
    sId = json['_id'];
    portfolio = json['portfolio'];
    profileInfo = json['info'] != null ? new ProfileInfo.fromJson(json['info']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roles'] = this.roles;
    data['_id'] = this.sId;
    data['portfolio'] = this.portfolio;
    if (this.profileInfo != null) {
      data['info'] = this.profileInfo.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class ProfileInfo {
  List<String> programs;
  String nickname;
  String phoneNumber;
  String email;
  String location;
  String desc;

  ProfileInfo(
      {this.programs,
      this.nickname,
      this.phoneNumber,
      this.email,
      this.location,
      this.desc});

  ProfileInfo.fromJson(Map<String, dynamic> json) {
    programs = json['programs'].cast<String>();
    nickname = json['nickname'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    location = json['location'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['programs'] = this.programs;
    data['nickname'] = this.nickname;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['location'] = this.location;
    data['desc'] = this.desc;
    return data;
  }
}