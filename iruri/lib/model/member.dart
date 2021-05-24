class Member {
  final String id;
  final List<String> roles;
  final String portfolio;
  final Info info;

  Member({this.id, this.info, this.portfolio, this.roles});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        id: json['_id'],
        roles: json['roles'] != null ? List.from(json['roles']) : [],
        portfolio: json['portfolio'],
        info: Info.fromJson(json['info']));
  }

  // for posting new article
  Map<String, dynamic> toJson() =>
      {'roles': roles, 'portfolio': portfolio, 'info': info.toJson()};
}

class Info {
  final String nickname;
  final String phoneNumber;
  final String email;
  Info({this.email, this.nickname, this.phoneNumber});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      nickname: json['location']);

  Map<String, dynamic> toJson() => {
        'email': email,
        'nickname': nickname,
        'phoneNumber': phoneNumber,
      };
}