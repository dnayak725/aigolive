import 'dart:convert';
import 'package:aigolive/chat/models/notificationModel.dart';
import 'package:aigolive/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> notificationList = [];
  String listFetchingStatus = "fetching";

  fetchNotificationData(String userId) async {
    final response = await http.get(
      ApiLinks().getNotificationsApi + "/$userId",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          listFetchingStatus = results['status'];
          var data = results['data'];
          List<NotificationModel> temp = [];
          data.forEach((item) {
            temp.add(
              NotificationModel(
                id: item['id'].toString(),
                notificationHeader: item['notificationHeader'].toString(),
                message: item['message'].toString(),
                pageLink: item['pageLink'].toString(),
                receipientId: item['receipientId'].toString(),
                receipientType: item['receipientType'].toString(),
                receipientRead: item['receipientRead'].toString(),
                notificationType: item['notificationType'].toString(),
                metaData: item['metaData'].toString(),
                icon: item['icon'].toString(),
                buttonName: item['buttonName'].toString(),
                time: item['time'].toString(),
              ),
            );
          });
          if (temp.length > 0)
            notificationList = temp;
          else
            notificationList = [];
        }
        break;

      default:
        print("LTPL: Notification api error");
        break;
    }
    notifyListeners();
  }
}
