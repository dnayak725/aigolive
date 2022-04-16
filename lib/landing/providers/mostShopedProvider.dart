import 'package:aigolive/landing/models/mostShoppedModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class MostShopedProvider with ChangeNotifier {
  List<MostShopped> mostShopedList = [];
  int fetchingStatus = 0;

  fetchData() async {
    final response = await http.get(
      ApiLinks().mostShopedApi,
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
          List<MostShopped> temp = [];
          data.forEach((item) {
            temp.add(
              MostShopped(
                id: item['id'].toString(),
                sessionThumbnail: item['session_thumbnail'].toString(),
                sessionName: item['session_name'].toString(),
                sessionDescription: item['session_description'].toString(),
                shopName: item['shoP_NAME'].toString(),
                daysMonth: item['daysmnth'].toString(),
                textDays: item['textdays'].toString(),
                shopLogo: item["shoplogo"].toString(),
                sellerId: item["sellerId"].toString(),
                noOfViews: item["noofViews"].toString(),
                videoLink: item["videoLink"].toString(),
              ),
            );
          });
          mostShopedList = temp;
        }
        break;

      default:
        print("Error:" +response.statusCode.toString()+": Most shopped API error.");
        break;
    }
    fetchingStatus=response.statusCode;
    notifyListeners();
  }
}
