import 'package:flutter/material.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/model/user.dart';

class CustomRouter with ChangeNotifier {
  int _tapIndex = 0;
  String _currPage = '/';
  String _prevPage = '/';
  dynamic _data;
  bool isLoggedin = false;
  User _user;
  Article _article;

  int get index => _tapIndex;
  String get currentPage => _currPage;
  String get prevPage => _prevPage;
  dynamic get data => _data != null ? _data : 'undefined';
  User get user => _user != null ? _user : new User();
  Article get article => _article != null ? _article : new Article();

  CustomRouter(this.isLoggedin);

  void setIndex(int index) {
    _tapIndex = index;
    notifyListeners();
  }

  void setRegistrationStatus(bool status) {
    isLoggedin = status;
    setIndex(0);
    notifyListeners();
  }

  void navigateTo(String from, String dest,
      {dynamic data, User user, Article article}) {
    _prevPage = from;
    _currPage = dest;

    // data
    _data = data;
    _article = article;
    notifyListeners();
  }
}

class UserState with ChangeNotifier {
  User _user;

  User get currentUser => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
