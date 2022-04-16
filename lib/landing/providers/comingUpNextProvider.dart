import 'package:aigolive/landing/models/comingUpNextModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class ComingUpNextProvider with ChangeNotifier {
  List<CoomingUpNext> comingUpNextList = [];
  int isFetching = 0;

  fetchData() async {
    final response = await http.get(
      ApiLinks().comingUpNextApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    isFetching=response.statusCode;
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          var data = results['data'];
          List<CoomingUpNext> temp = [];
          data.forEach((item) {
            temp.add(
              CoomingUpNext(
                id: item['id'].toString(),
                sessionDate: item['session_date'].toString(),
                sessionTime: item['session_time'].toString(),
                sellerId: item['sellerid'].toString(),
                sessionId: item['session_id'].toString(),
                sessionThumbnail: item['session_thumbnail'].toString(),
                sessionName: item['session_name'].toString(),
                shopDescription: item["shopDescription"].toString(),
                shopName: item["shopName"].toString(),
                sessionDescription: item["session_description"].toString(),
                shopLogo: item['shoplogo'].toString(),
                watching: item['watching'].toString(),
                sessionPageLink: item['sessionPageLink'].toString(),
                sessionVideoLink: item['sessionvideoLink'].toString(),
              ),
            );
          });
          comingUpNextList = temp;
        }
        
        break;

      default:
        print("Error:" +
            response.statusCode.toString() +
            ": Coming up API error.");
        break;
    }
    notifyListeners();
  }
}
