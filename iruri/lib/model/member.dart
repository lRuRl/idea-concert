class Member {
  final String id;
  final List<String> roles;
  final String portfolio;
  final Info info;

  Member({this.id, this.info, this.portfolio, this.roles});
}

class Info {
  final String nickname;
  final String phoneNumber;
  final String email;
  Info({this.email, this.nickname, this.phoneNumber});
}
