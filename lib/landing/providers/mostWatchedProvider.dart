import 'package:aigolive/landing/models/comingUpNextModel.dart';
import 'package:aigolive/landing/models/mostWatchedModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class MostWatchedProvider with ChangeNotifier {
  List<MostWatched> mostWatchedList = [];
  int fetchingStatus = 0;

  fetchData() async {
    final response = await http.get(
      ApiLinks().mostWatchedApi,
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
          List<MostWatched> temp = [];
          data.forEach((item) {
            temp.add(
              MostWatched(
                  sid: item["sid"].toString(),
                  id: item["id"].toString(),
                  sessionDate: item["session_date"].toString(),
                  sessionTime: item["session_time"].toString(),
                  sellerId: item["sellerid"].toString(),
                  sessionId: item["session_id"].toString(),
                  sessionThumbnail: item["session_thumbnail"].toString(),
                  sessionName: item["session_name"].toString(),
                  shopDescription: item["shopDescription"].toString(),
                  shopName: item["shopName"].toString(),
                  daysMonth: item["daysmnth"].toString(),
                  textDays: item["textdays"].toString(),
                  sessionDescription: item["session_description"].toString(),
                  optionName: item["option_name"].toString(),
                  shopLogo: item["shoplogo"].toString(),
                  watching: item["watching"].toString(),
                  sessionVideoLink: item["videoLink"].toString()),
            );
          });
          mostWatchedList = temp;
        }
        break;

      default:
        print("Error:" +
            response.statusCode.toString() +
            ": Most watched API error.");
        break;
    }
    fetchingStatus = response.statusCode;
    notifyListeners();
  }
}
