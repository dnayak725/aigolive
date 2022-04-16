import 'package:aigolive/config/config.dart';
import 'package:aigolive/live-steaming/models/UserMessagesModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserMessageProvider with ChangeNotifier {
  List<UserMessagesModel> userMessage = [];
  bool showFullPage = false;

  ChangeCommentSize(bool status) {
    showFullPage = status;
    notifyListeners();
  }

  fetchData(String sessionId) async {
    final response = await http.get(
      ApiLinks().getPublicChatListApi + "/$sessionId",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          var data = results['data'];
          List<UserMessagesModel> temp = [];
          data.forEach((item) {
            temp.add(
              UserMessagesModel(
                message: item['message'].toString(),
                time: item['time'].toString(),
                sellerFName: item['seller_F_name'].toString(),
                sellerLName: item['seller_L_name'].toString(),
                custFName: item['cust_F_name'].toString(),
                custLName: item['cust_L_name'].toString(),
                custPic: item['cust_pic'].toString(),
                sellerPic: item['seller_pic'].toString(),
                shopName: item['shop_name'].toString(),
                shopLogo: item['shop_logo'].toString(),
                fullName: item['seller_F_name'] != ""
                    ? item['seller_F_name'].toString() +
                        item['seller_L_name'].toString()
                    : item['cust_F_name'].toString() +
                        item['cust_L_name'].toString(),
                profileImage: item['seller_F_name'] != ""
                    ? item['seller_pic'].toString()
                    : item['cust_pic'].toString(),
              ),
            );
            if (temp.length > 0) {
              userMessage = temp;
            } else {
              userMessage = [];
            }
          });
        }
        break;

      default:
        print("LTPL: Comment api error" + response.statusCode.toString());
        break;
    }
    notifyListeners();
  }

  addNewMessage(String sessionId, String message) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.post(
      ApiLinks().sendMessagePublicChatApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "sses_id": int.parse(sessionId),
        "cust_id": int.parse(sharedPreferences.getString("user_id")),
        "input_val": message,
      }),
    );

    switch (response.statusCode) {
      case 200:
        print("LTPL: Comment success");
        break;

      default:
        print("LTPL: Comment error");
        break;
    }
    fetchData(sessionId);
  }

  reset() {
    userMessage = [];
  }
}
