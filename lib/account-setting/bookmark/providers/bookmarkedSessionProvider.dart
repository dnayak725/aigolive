import 'dart:convert';

import 'package:aigolive/account-setting/bookmark/models/bookmarkedSessionModel.dart';
import 'package:aigolive/account-setting/bookmark/models/categoryModel.dart';
import 'package:aigolive/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkedSessionProvider with ChangeNotifier {
  List<BookmarkedSessionModel> bookmarkedSessionList = [];
  var localUserId;

  getLocalUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('user_id')) {
      localUserId = pref.getString("user_id");
      fetchData(localUserId);
    }
    notifyListeners();
  }

  String key = '';

  addNewSession(BookmarkedSessionModel bookmarkedSessionModel) {
    if (key == '') {
      bookmarkedSessionList.add(bookmarkedSessionModel);
    } else {
      print(key);
      bookmarkedSessionList.add(bookmarkedSessionModel);
    }
    notifyListeners();
  }

  removeOrAddSession(
      String sessionId, String sellerId, bool removeOrAdd) async {
    String id = "0";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      id = sharedPreferences.getString("user_id");
    }
    final response = await http.put(
      AppConfig().apiLink + "Customer/BookMarkedSession",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "CustID": int.parse(id),
        "SellerID": int.parse(sellerId),
        "SessionID": int.parse(sessionId),
        "chk_val": removeOrAdd
      }),
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "Success") {
          fetchData(id);
        }
    }
    notifyListeners();
  }

  fetchData(String id) async {
    final response = await http.get(
      AppConfig().apiLink + "Customer/GetBookmarkSession/" + id,
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
          List<BookmarkedSessionModel> temp = [];
          print(data);
          data.forEach((item) {
            temp.add(
              BookmarkedSessionModel(
                id: item["id"].toString(),
                logoUrl: item["sellerLogo"].toString(),
                sessId: item["sessId"].toString(),
                shopName: item["shopName"].toString(),
                sellerId: item["sellerID"].toString(),
                sessionId: item["sessionID"].toString(),
                sessionName: item["sessionName"].toString(),
                sessionThumbnail: item["sessionThumbnail"].toString(),
                sessionDate: item["sessionDate"].toString(),
                sessionTime: item["sessionTime"].toString(),
                sessionPageLink: item["sessionPageLink"].toString(),
                categoryList: BMCategoryModel(
                  id: item['categories'][0]['id'].toString(),
                  name: item['categories'][0]['name'].toString(),
                ),
              ),
            );
            bookmarkedSessionList = temp;
          });
        }
        // print("LTPL: GetBookmarkSession api fetched");
        break;

      default:
        print("LTPL: GetBookmarkSession api error");
        break;
    }
    notifyListeners();
  }

  setKey(String value) {
    key = value;
    notifyListeners();
  }

  reset() {
    bookmarkedSessionList = [];
    notifyListeners();
  }
}
