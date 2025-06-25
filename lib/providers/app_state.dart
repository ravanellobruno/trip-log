import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  var pageIndex = 0;
  var prevPageIndex = 0;

  void setPageIndex(int i) {
    prevPageIndex = pageIndex;
    pageIndex = i;
    notifyListeners();
  }
}
