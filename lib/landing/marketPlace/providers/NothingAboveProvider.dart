import 'package:aigolive/config/config.dart';
import 'package:aigolive/landing/marketPlace/models/MKProductModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NothingAboveProvider with ChangeNotifier {
  List<MKProductModel> nothingAboveProductList = [];
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
    final response = await http.get(
      ApiLinks().nothingAboveApi,
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
          // print(data);
          List<MKProductModel> temp = [];
          data.forEach((item) {
            temp.add(
              MKProductModel(
                item['product_id'].toString(),
                item['product_name'].toString(),
                item['product_image'].toString(),
                item['product_selling_price'].toString(),
                item['product_price'].toString(),
                item['discountpercent'].toString(),
                item['quantity'].toString(),
                item['seller_id'].toString(),
                "",
               item['totalsold'].toString()
              ),
            );
          });

          if (temp.length > 0) {
            nothingAboveProductList = temp;
          } else {
            nothingAboveProductList = [];
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
