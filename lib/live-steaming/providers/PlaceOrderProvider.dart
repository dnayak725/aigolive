import 'package:aigolive/config/config.dart';
import 'package:aigolive/live-steaming/models/UserMessagesModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserMessageProvider with ChangeNotifier {
  List<UserMessagesModel> userMessage = [];
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
            userMessage = temp;
          });
        }
        break;

      default:
        print(
            "LTPL: product details api error" + response.statusCode.toString());
        break;
    }
    notifyListeners();
  }
  // addNewMessage(String message) {
  //   userMessage.insert(
  //     0,
  //     new UserMessagesModel(
  //       id: userMessage.length,
  //       userName: 'You',
  //       message: message,
  //     ),
  //   );
  //   notifyListeners();
  // }
}
