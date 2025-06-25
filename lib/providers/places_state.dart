import 'package:flutter/material.dart';

class PlacesState extends ChangeNotifier {
  int? idToUpdate;

  void setIdToUpdate(int? id) {
    idToUpdate = id;
    notifyListeners();
  }
}
