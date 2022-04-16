import 'package:aigolive/landing/models/bannerTagModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class BannerTagProvider with ChangeNotifier {
  List<BannerTag> bannerTagList = [];
  int status = 0;
  fetchData() async {
    final response = await http.get(
      ApiLinks().bannerTagsApi,
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
          List<BannerTag> temp = [];
          data.forEach((item) {
            temp.add(
              BannerTag(
                id: item['catid'].toString(),
                name: item['categoryname'].toString(),
                img: item['istagimage'].toString(),
              ),
            );
          });
          bannerTagList = temp;
        }
        break;

      default:
        print("Error:" +
            response.statusCode.toString() +
            ": Banner tag API error.");
        break;
    }
    status = response.statusCode;
    notifyListeners();
  }
}
