import 'package:aigolive/config/config.dart';
import 'package:aigolive/stores/models/live_stream_data_model.dart';
import 'package:aigolive/stores/models/product_model.dart';
import 'package:aigolive/stores/models/storeModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FollowedStoreProvider with ChangeNotifier {
  List<StoreModel> stores = [];
  String key = '';
  String localUserId;
  addNewStore(StoreModel storeModel) {
    // if (key == '') {
    //   bookmarkedSessionList.add(bookmarkedSessionModel);
    // } else {
    //   print(key);

    //   bookmarkedSessionList.add(bookmarkedSessionModel);
    // }
    stores.add(storeModel);
    notifyListeners();
  }

  getLocalUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('user_id')) {
      localUserId = pref.getString("user_id");
      fetchData(localUserId);
    }
    notifyListeners();
  }

  unfollowStore(String storeID, String customerID, bool status) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    stores.forEach((item) {
      if (item.storeID == storeID) {
        item.isFollow = status;
      }
    });
    final response = await http.put(
      ApiLinks().followUnfollowApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "CustID": int.parse(sharedPreferences.getString("user_id")),
        "SellerID": int.parse(storeID),
        "chk_val": status,
      }),
    );
    // print("LTPL: called" + response.statusCode.toString());

    switch (response.statusCode) {
      case 200:
        print("LTPL: Follow request success");
        break;

      default:
        print("LTPL: Follow request error");
        break;
    }
    fetchData(sharedPreferences.getString("user_id"));
  }

  fetchData(String id) async {
    final response = await http.get(
      AppConfig().apiLink + "Customer/GetFollowings/" + id,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    // print("LTPL: called" + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          var data = results['data'];
          // print(data);
          List<StoreModel> temp = [];
          int i = 12;
          data.forEach((item) {
            temp.add(
              StoreModel(
                id: item['id'].toString(),
                status: item['status'].toString(),
                storeLogo: item['pic'].toString(),
                storeName: item['shopName'].toString(),
                storeID: item['sellerID'].toString(),
                customerID: item['custID'].toString(),
                dateJoined: item['dJoined'].toString(),
                totalFollowers: item['totalfollowers'].toString(),
                isFollow: true,
              ),
            );
            stores = temp;
          });
        }
        print("LTPL: GetFollowings api data fetched");
        break;

      default:
        print("LTPL: GetFollowings api error");
        break;
    }
    notifyListeners();
  }

  setKey(String value) {
    key = value;

    notifyListeners();
  }

  reset() {}
}
