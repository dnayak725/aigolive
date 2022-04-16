import 'package:flutter/foundation.dart';

class LoginDetailsModel {
  final int userID;
  final String userName;
  final String profilePic;

  LoginDetailsModel(@required this.userID, @required this.userName,
      @required this.profilePic);
}
