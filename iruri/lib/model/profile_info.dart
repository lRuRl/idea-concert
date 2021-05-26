class User {
  List<String> roles;
  String sId;
  String portfolio;
  ProfileInfo profileInfo;

  User({this.roles, this.sId, this.portfolio, this.profileInfo});

  factory User.fromJson(Map<String, dynamic> json) => User(
      roles: List.from(json['roles']),
      sId: json['_id'],
      portfolio: json['portfolio'],
      profileInfo:
          json['info'] != null ? new ProfileInfo.fromJson(json['info']) : null,);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roles'] = this.roles;
    data['_id'] = this.sId;
    data['portfolio'] = this.portfolio;
    if (this.profileInfo != null) {
      data['info'] = this.profileInfo.toJson();
    }
    return data;
  }
}

class ProfileInfo {
  List<String> programs;
  String nickname;
  String password;
  String phoneNumber;
  String email;
  String location;
  String desc;

  ProfileInfo(
      {this.programs,
      this.nickname,
      this.password,
      this.phoneNumber,
      this.email,
      this.location,
      this.desc});

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
      programs: List.from(json['programs']),
      nickname: json['nickname'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      location: json['location'],
      desc: json['desc']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['programs'] = this.programs;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['location'] = this.location;
    data['desc'] = this.desc;
    return data;
  }
}