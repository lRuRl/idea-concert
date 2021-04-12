import 'package:flutter/material.dart';

class CustomRouter with ChangeNotifier {
  int _tapIndex = 0;
  String _currPage = '/';
  String _prevPage = '/';
  dynamic _data;

  int get index => _tapIndex;
  String get currentPage => _currPage;
  String get prevPage => _prevPage;
  dynamic get data => _data != null ? _data : 'undefined';

  void setIndex(int index) {
    _tapIndex = index;
    notifyListeners();
  }

  void navigateTo(String from, String dest, {dynamic data}) {
    _prevPage = from;
    _currPage = dest;
    // data
    _data = data;
    notifyListeners();
  }
}
