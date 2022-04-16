import 'package:aigolive/config/config.dart';
import 'package:aigolive/landing/marketPlace/models/MKProductModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedProductListProvider with ChangeNotifier {
  List<MKProductModel> recommendedProductList = [];
  String listFetchingStatus = "fetching";

  // void setWeeklyDealsProductList(List<MKProductModel> list){
  //   if(list.length>0){
  //       weeklyDealsProductList = list;
  //   }else{
  //     weeklyDealsProductList = [];
  //   }
  //   notifyListeners();
  // }

  fetchData() async {
    String id = "0";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('status') &&
        sharedPreferences.getString("status") == "success") {
      id = sharedPreferences.getString("user_id").toString();
    }
    final response = await http.get(
      ApiLinks().recommendedProductListApi + id,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          listFetchingStatus = "success";
          var data = results['data'];
          List<MKProductModel> temp = [];
          data.forEach((item) {
            temp.add(
              MKProductModel(
                item['product_id'].toString(),
                item['productname'].toString(),
                item['product_image'].toString(),
                item['product_selling_price'].toString(),
                item['product_price'].toString(),
                item['discountpercent'].toString(),
                item['quantity'].toString(),
                item['seller_id'].toString(),
                "",
                item['total_sold'].toString(),
              ),
            );
          });

          if (temp.length > 0) {
            recommendedProductList = temp;
          } else {
            recommendedProductList = [];
          }
        }
        // print("LTPL: GetOnAirStream api data fetched");
        break;

      default:
        print("LTPL: GetOnAirStream api error");
        break;
    }
    notifyListeners();
  }
}
