import 'package:aigolive/landing/models/recommendedModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedProvider with ChangeNotifier {
  List<Recommended> recomendedList = [];
  int fetchingStatus = 0;

  fetchData() async {
    String id = "0";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('status') &&
        sharedPreferences.getString("status") == "success") {
      id = sharedPreferences.getString("user_id").toString();
    }
    final response = await http.get(
      ApiLinks().recommendedApi + id,
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
          List<Recommended> temp = [];
          data.forEach((item) {
            temp.add(
              Recommended(
                id: item["id"].toString(),
                sessionDate: item["session_date"].toString(),
                sessionTime: item["session_time"].toString(),
                sellerId: item["sellerid"].toString(),
                sessionId: item["session_id"].toString(),
                sessionThumbnail: item["session_thumbnail"].toString(),
                sessionName: item["session_name"].toString(),
                shopDescription: item["shopDescription"].toString(),
                shopName: item["shopName"].toString(),
                daysMnth: item["daysmnth"].toString(),
                textDays: item["textdays"].toString(),
                sessionDescription: item["session_description"].toString(),
                shopLogo: item["shoplogo"].toString(),
                watching: item["watching"].toString(),
                videoLink: item["videoLink"].toString(),
              ),
            );
          });
          recomendedList = temp;
        }
        break;

      default:
        print("Error:" +
            response.statusCode.toString() +
            ": Recommended session list API error.");
        break;
    }
    fetchingStatus = response.statusCode;
    notifyListeners();
  }
}
