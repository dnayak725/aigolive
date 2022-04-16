import 'dart:convert';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/landing/models/productCategoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<Category> categoryList = [];
  String listFetchingStatus = "fetching";
  int activeCategory = 0;
  List<SubCategory> subCatList = [];
  void setActiveCategory(int activeVal) {
    activeCategory = activeVal;
    notifyListeners();
  }

  void showSubcategoryList(int activeVal) {
    int cat = categoryList
        .indexWhere((element) => categoryList.indexOf(element) == activeVal);
    subCatList = categoryList[cat].subCatList;
  }

  fetchData() async {
    final response = await http.get(
      ApiLinks().categorySubcategoryApi,
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
          listFetchingStatus = results['status'];
          var data = results['data'];
          List<Category> temp = [];

          data.forEach((item) {
            List subCatData = item['subcategory'];
            List<SubCategory> subCatTemp = [];
            subCatData.forEach((elem) {
              subCatTemp.add(
                SubCategory(
                  id: elem['id'].toString(),
                  name: elem['categories'].toString(),
                  image: elem['categoryicon'] != ""
                      ? elem['categoryicon'].toString()
                      : "https://agl.bluecube.com.sg/upload/categoryicon/category_default.png",
                ),
              );
            });

            temp.add(
              Category(
                id: item['inT_CAT_ID'].toString(),
                name: item['categories'].toString(),
                iType: item['iType'].toString(),
                catId: item['catId'].toString(),
                parentID: item['parenT_ID'].toString(),
                image: item['categoryicon'] != ""
                    ? item['categoryicon'].toString()
                    : "https://agl.bluecube.com.sg/upload/categoryicon/category_default.png",
                subCatList: subCatTemp,
              ),
            );
          });
          categoryList = temp;
        }
        print("LTPL: Category api data fetched");
        break;

      default:
        print("LTPL: Category api error");
        break;
    }
    notifyListeners();
  }
}
