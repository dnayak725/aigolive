import 'package:flutter/material.dart';

class UserLoginStatusProvider with ChangeNotifier {
  String loginStatus = "unknown";
  String userID = "0";
  setLoginStatus(String status) {
    loginStatus = status;
    notifyListeners();
  }

  setUserID(String id) {
    userID = id;
    print(this.userID);
    notifyListeners();
  }
  // get
}
