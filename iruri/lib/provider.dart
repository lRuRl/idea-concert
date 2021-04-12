import 'package:flutter/material.dart';

class CustomRouter with ChangeNotifier {
  int _tapIndex = 0;
  String _currPage = '/';
  String _prevPage = '/';

  int get index => _tapIndex;
  String get currentPage => _currPage;
  String get prevPage => _prevPage;

  void setIndex(int index) {
    _tapIndex = index;
    notifyListeners();
  }

  void navigateTo(String from, String dest) {
    _prevPage = from;
    _currPage = dest;
    notifyListeners();
  }
}
