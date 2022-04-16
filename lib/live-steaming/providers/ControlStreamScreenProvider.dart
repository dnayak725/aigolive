import 'package:flutter/material.dart';

class ControlStreamScreenPovider with ChangeNotifier {
  //keyboard status code
  bool _keyboardState;

  bool get keyBoardStatus {
    return _keyboardState;
  }

  void setKeyBoardStatus(bool status) {
    _keyboardState = status;
    notifyListeners();
  }
  //end keyboard status code

  //keyboard status code
  int _productsViewMode = 1;

  int get productsViewMode {
    return _productsViewMode;
  }

  void setProductsViewMode(int status) {
    _productsViewMode = status;
    notifyListeners();
  }
  //end keyboard status code
}
