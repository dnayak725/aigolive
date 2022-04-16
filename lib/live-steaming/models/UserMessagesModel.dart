import 'package:flutter/foundation.dart';

class UserMessagesModel {
  final String message;
  final String time;
  final String sellerFName;
  final String sellerLName;
  final String custFName;
  final String custLName;
  final String custPic;
  final String sellerPic;
  final String shopName;
  final String shopLogo;
  final String fullName;
  final String profileImage;

  UserMessagesModel({
    this.message,
    this.time,
    this.sellerFName,
    this.sellerLName,
    this.custFName,
    this.custLName,
    this.custPic,
    this.sellerPic,
    this.shopName,
    this.shopLogo,
    this.fullName,
    this.profileImage,
  });
}
