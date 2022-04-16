import 'package:aigolive/config/config.dart';
import 'package:aigolive/live-steaming/models/SessionDetailsProductsModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SessionDetailsProductsProvider with ChangeNotifier {
  SessionDetailsProductsModel sessionDetails;
  List<SessionDetailsProducts> sessionProducts = [];

  fetchData(String sessionId) async {
    final response = await http.get(
      ApiLinks().getSessionDetailsWithProductsApi + "/$sessionId",
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
          var products = results['data'][0]["products"];
          List<SessionDetailsProducts> temp = [];
          products.forEach((item) {
            temp.add(
              SessionDetailsProducts(
                productId: item['product_id'].toString(),
                sellerId: item['seller_id'].toString(),
                productName: item['product_name'].toString(),
                productImage: item['product_image'].toString(),
                productDescription: item['product_description'].toString(),
                productPrice: item['product_price'].toString(),
                productSellingPrice: item['product_selling_price'].toString(),
                discountPercent: item['discountpercent'].toString(),
                quantity: item['quantity'].toString(),
              ),
            );
          });
          sessionProducts = temp;
          sessionDetails = SessionDetailsProductsModel(
            sessionId: data[0]["sessionId"].toString(),
            sellerId: data[0]["sellerId"].toString(),
            autoSessionid: data[0]["autoSessionid"].toString(),
            sessionThumbnail: data[0]["sessionThumbnail"].toString(),
            sessionName: data[0]["sessionName"].toString(),
            sessionDescription: data[0]["sessionDescription"].toString(),
            createdDate: data[0]["createdDate"].toString(),
            videoLink: data[0]["videoLink"].toString(),
            products: sessionProducts,
          );
        }
        break;
      default:
        print("SessionDetails api error" + response.statusCode.toString());
        break;
    }
    notifyListeners();
  }

  reset() {
    sessionProducts = [];
  }
}
