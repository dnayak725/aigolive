import 'package:aigolive/landing/models/newThisWeekModel.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class OnAirStreamsProvider with ChangeNotifier {
  List<NewThisWeek> newThisWeek = [];
  int isFetching = 0;

  fetchData() async {
    final response = await http.get(
      AppConfig().apiLink + "Customer/Newthisweek",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    print("LTPL: called" + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          var data = results['data'];
          List<NewThisWeek> temp = [];
          data.forEach((item) {
            temp.add(
              NewThisWeek(
                id: item['id'].toString(),
                sessionId: item['session_id'].toString(),
                sessionThumbnail: item['session_thumbnail'].toString(),
                sessionName: item['session_name'].toString(),
                shopDescription: item['shopDescription'].toString(),
                shopName: item['shopName'].toString(),
                sessionLink: item['sessionlink'].toString(),
                shopLogo: item['shoplogo'].toString(),
                sessionDescription: item['session_description'].toString(),
                sessionDate: item['sessionDate'].toString(),
                sessionTime: item['sessionTime'].toString(),
                watching: item['watching'].toString(),
                sellerId: item['sellerid'].toString(),
                videoLink: item['videoLink'].toString(),
                pageLink: item['pageLink'].toString(),
              ),
            );
          });
          newThisWeek = temp;
        }
        print("LTPL: GetOnAirStream api data fetched");
        break;

      default:
        print("LTPL: GetOnAirStream api error");
        break;
    }
    isFetching = response.statusCode;
    notifyListeners();
  }
}
