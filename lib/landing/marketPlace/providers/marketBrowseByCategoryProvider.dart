import 'package:aigolive/landing/marketPlace/models/searchProductListBySearchKeyModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class MarketBrowseByCategoryProvider with ChangeNotifier {
  List<SearchProductListBySearchKeyModel> searchProductList = [];
  int fetchingStatus = 0;
  String priceOrder = "ASC";

  int activeFilterIndex = 0;
  void filterProducts(filterValue, filterIndex) {
    switch (filterValue) {
      case "Recent":
        Comparator<SearchProductListBySearchKeyModel> idComparator =
            (a, b) => b.productId.compareTo(a.productId);
        searchProductList.sort(idComparator);
        break;
      case "Price":
        Comparator<SearchProductListBySearchKeyModel> viewComparator;
        if (priceOrder == "ASC") {
          viewComparator = (a, b) => double.parse(a.productSellingPrice)
              .compareTo(double.parse(b.productSellingPrice));
          priceOrder = "DESC";
        } else {
          viewComparator = (b, a) => double.parse(a.productSellingPrice)
              .compareTo(double.parse(b.productSellingPrice));
          priceOrder = "ASC";
        }
        searchProductList.sort(viewComparator);
        break;
      default:
        Comparator<SearchProductListBySearchKeyModel> idComparator =
            (a, b) => a.productId.compareTo(b.productId);
        searchProductList.sort(idComparator);
    }
    activeFilterIndex = filterIndex;
    notifyListeners();
  }

  fetchDataById(int id) async {
    print(id);
    final response = await http.get(
      ApiLinks().searchProductDetailsByCategoryIdApi + "/$id",
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
          List<SearchProductListBySearchKeyModel> temp = [];
          data.forEach((item) {
            temp.add(
              SearchProductListBySearchKeyModel(
                productId: item['product_id'],
                sellerId: item['seller_id'].toString(),
                productName: item['product_name'].toString(),
                productImage: item['product_image'].toString(),
                productDescription: item['product_description'].toString(),
                productPrice: double.parse(item['product_price'].toString()),
                productSellingPrice: item['product_selling_price'].toString(),
                discountpercent: item['discountpercent'].toString(),
                quantity: item['quantity'].toString(),
                totalSold: item['totalsold'].toString(),
              ),
            );
          });
          if (temp.length > 0)
            searchProductList = temp;
          else
            searchProductList = [];
        }
        break;

      default:
        print("LTPL: SearchProductListByCategory api error");
        break;
    }
    notifyListeners();
  }

  fetchDataByName(String categoryName) async {
    final response = await http.get(
      ApiLinks().searchProductDetailsBySearchkeyApi + "/$categoryName",
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
          List<SearchProductListBySearchKeyModel> temp = [];
          data.forEach((item) {
            temp.add(
              SearchProductListBySearchKeyModel(
                productId: item['product_id'],
                sellerId: item['seller_id'].toString(),
                productName: item['product_name'].toString(),
                productImage: item['product_image'].toString(),
                productDescription: item['product_description'].toString(),
                productPrice: double.parse(item['product_price'].toString()),
                productSellingPrice: item['product_selling_price'].toString(),
                discountpercent: item['discountpercent'].toString(),
                quantity: item['quantity'].toString(),
                totalSold: item['totalsold'].toString(),
              ),
            );
          });
          if (temp.length > 0)
            searchProductList = temp;
          else
            searchProductList = [];
        }
        break;

      default:
        break;
    }
    notifyListeners();
  }

  reset() {
    searchProductList = [];
    fetchingStatus = 0;
    priceOrder = "ASC";
  }
}
