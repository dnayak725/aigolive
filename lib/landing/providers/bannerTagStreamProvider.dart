import 'package:aigolive/landing/models/searchSessionListByCategory.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class BannerTagStreamProvider with ChangeNotifier {
  List<SearchSessionListByCategory> searchSessionList = [];
  int fetchingStatus = 0;

  fetchDataById(int id) async {
    final response = await http.get(
      ApiLinks().searchSessionListByCategoryIdApi + "/$id",
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
          List<SearchSessionListByCategory> temp = [];
          data.forEach((item) {
            temp.add(
              SearchSessionListByCategory(
                sid: item['sid'].toString(),
                id: item['id'],
                sessionDate: item['session_date'].toString(),
                sessionTime: item['session_time'].toString(),
                sellerId: item['sellerid'].toString(),
                sessionId: item['session_id'].toString(),
                sessionThumbnail: item['session_thumbnail'].toString(),
                sessionName: item['session_name'].toString(),
                shopDescription: item['shopDescription'].toString(),
                shopName: item['shopName'].toString(),
                daysMonth: item['daysmnth'].toString(),
                textDays: item['textdays'].toString(),
                sessionDescription: item['session_description'].toString(),
                optionName: item['option_name'].toString(),
                shopLogo: item['shoplogo'].toString(),
                watching: item['watching'].toString(),
                pageLink: item['pageLink'].toString(),
                videoLink: item['videoLink'].toString(),
                totalSessionWatching: item['totalsessionwatching'],
              ),
            );
          });
          searchSessionList = temp;
        }
        break;

      default:
        print("Error:" +
            response.statusCode.toString() +
            ": Banner tag's session list API error.");
        break;
    }
    fetchingStatus = response.statusCode;
    notifyListeners();
  }
}
