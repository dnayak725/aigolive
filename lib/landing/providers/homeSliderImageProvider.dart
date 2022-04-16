import 'package:aigolive/landing/models/mainSlider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class HomeSliderImageProvider with ChangeNotifier {
  List<MainSliderImage> sliderImageList = [];
  int status = 0;
  fetchData() async {
    final response = await http.get(
      ApiLinks().homescreenSliderImagesApi,
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
          List<MainSliderImage> temp = [];
          data.forEach((item) {
            temp.add(
              MainSliderImage(
                img: item['images'],
              ),
            );
          });
          sliderImageList = temp;
        }
        status=200;
        break;

      default:
        print("Error "+response.statusCode.toString()+": SliderImage api error");
        break;
    }
    notifyListeners();
  }
}
