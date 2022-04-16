import 'package:aigolive/landing/marketPlace/models/MarketSliderModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class MarketSliderImageProvider with ChangeNotifier {
  List<MarketSliderImage> sliderImageList = [];
  String status = "fetching";
  fetchData() async {
    final response = await http.get(
      ApiLinks().marketPlaceSliderImagesApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    print("LTPL slidera: called" + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);

        if (results['status'] == "success") {
          status = results['status'];
          var data = results['data'];
          List<MarketSliderImage> temp = [];
          data.forEach((item) {
            temp.add(
              MarketSliderImage(
                img: item['images'],
              ),
            );
          });
          sliderImageList = temp;
          status = "fetched";
        }
        print("LTPL: SliderImage api data fetched");
        break;

      default:
        print("LTPL: SliderImage api error");
        break;
    }
    notifyListeners();
  }
}
