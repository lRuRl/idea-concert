import 'package:flutter/material.dart';
import 'package:iruri/model/article.dart';
import 'package:iruri/model/user.dart';

/// this class manage nested page routing
/// [_tapIndex] stands for the bottom navigation bar index
/// [_currPage] is the page which user is looking at right now, current page
/// [_prevPage] is for remembering the previous page for router, pop back
/// [_data] is for data when data is needed between routing pages
/// this can be used or not, doesn't matters
/// [_article] is for data needed when [_data] is not enough for storage
/// this can be changed by merging with [_data] to List or removed
class CustomRouter with ChangeNotifier {
  // declaration
  int _tapIndex = 0;
  String _currPage = '/';
  String _prevPage = '/';
  dynamic _data;
  Article _article;
  // getter functions
  int get index => _tapIndex;
  String get currentPage => _currPage;
  String get prevPage => _prevPage;
  dynamic get data => _data != null ? _data : 'undefined';
  Article get article => _article != null ? _article : new Article();
  /// set index for navigation bar
  /// [index] matches with navigation tap length
  /// don't forget to write [notifyListeners()]
  /// when the state is needed to be changed
  void setIndex(int index) {
    _tapIndex = index;
    notifyListeners();
  }
  /// [from] will be previous page
  /// [dest] will be current page
  /// [data] and [article] is optional choice to route with data
  void navigateTo(String from, String dest,
      {dynamic data, Article article}) {
    _prevPage = from;
    _currPage = dest;

    // data
    _data = data;
    _article = article;
    notifyListeners();
  }
}
/// this class manage signed-in user
/// when the app disposes, application removes the user as well
/// [_user] where current user information is saved
class UserState with ChangeNotifier {
  User _user;
  // getter
  User get currentUser => _user;
  // setter
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
