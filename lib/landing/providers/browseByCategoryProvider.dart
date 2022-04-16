import 'package:aigolive/landing/models/searchSessionListByCategory.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class BrowseByCategoryProvider with ChangeNotifier {
  List<SearchSessionListByCategory> searchSessionList = [];
  String listFetchingStatus = "fetching data.";

  int activeFilterIndex = 0;
  void filterProducts(filterValue, filterIndex) {
    switch (filterValue) {
      case "Recent":
        Comparator<SearchSessionListByCategory> idComparator =
            (a, b) => b.id.compareTo(a.id);
        searchSessionList.sort(idComparator);
        break;
      case "Views":
        Comparator<SearchSessionListByCategory> viewComparator =
            (a, b) => a.totalSessionWatching.compareTo(b.totalSessionWatching);
        searchSessionList.sort(viewComparator);
        break;
      default:
        Comparator<SearchSessionListByCategory> idComparator =
            (a, b) => a.id.compareTo(b.id);
        searchSessionList.sort(idComparator);
    }
    activeFilterIndex = filterIndex;
    notifyListeners();
  }

  fetchDataById(int id) async {
    print(id);
    final response = await http.get(
      ApiLinks().searchSessionListByCategoryIdApi + "/$id",
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
          List<SearchSessionListByCategory> temp = [];
          data.forEach((item) {
            temp.add(
              SearchSessionListByCategory(
                sid: item['sid'].toString(),
                id: item['id'],
                sessionDate: item['session_date'].toString(),
                sessionTime: item['session_time'].toString(),
                sellerId: item['sellerid'].toString(),
                sessionId: item['session_id'].toString(),
                sessionThumbnail: item['session_thumbnail'].toString(),
                sessionName: item['session_name'].toString(),
                shopDescription: item['shopDescription'].toString(),
                shopName: item['shopName'].toString(),
                daysMonth: item['daysmnth'].toString(),
                textDays: item['textdays'].toString(),
                sessionDescription: item['session_description'].toString(),
                optionName: item['option_name'].toString(),
                shopLogo: item['shoplogo'].toString(),
                watching: item['watching'].toString(),
                pageLink: item['pageLink'].toString(),
                videoLink: item['videoLink'].toString(),
                totalSessionWatching: item['totalsessionwatching'],
              ),
            );
          });
          searchSessionList = temp;
        }
        print("LTPL: SearchSessionListByCategory api data fetched");
        break;

      default:
        print("LTPL: SearchSessionListByCategory api error");
        break;
    }
    notifyListeners();
  }

  fetchDataByName(String categoryName) async {
    final response = await http.get(
      ApiLinks().searchSessionListByCategoryNameApi + "/$categoryName",
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
          List<SearchSessionListByCategory> temp = [];
          data.forEach((item) {
            temp.add(
              SearchSessionListByCategory(
                sid: item['sid'].toString(),
                id: item['id'],
                sessionDate: item['session_date'].toString(),
                sessionTime: item['session_time'].toString(),
                sellerId: item['sellerid'].toString(),
                sessionId: item['session_id'].toString(),
                sessionThumbnail: item['session_thumbnail'].toString(),
                sessionName: item['session_name'].toString(),
                shopDescription: item['shopDescription'].toString(),
                shopName: item['shopName'].toString(),
                daysMonth: item['daysmnth'].toString(),
                textDays: item['textdays'].toString(),
                sessionDescription: item['session_description'].toString(),
                optionName: item['option_name'].toString(),
                shopLogo: item['shoplogo'].toString(),
                watching: item['watching'].toString(),
                pageLink: item['pageLink'].toString(),
                videoLink: item['videoLink'].toString(),
                totalSessionWatching: item['totalsessionwatching'],
              ),
            );
          });
          searchSessionList = temp;
        }
        print("LTPL: SearchSessionListByCategory api data fetched");
        break;

      default:
        print("LTPL: SearchSessionListByCategory api error");
        break;
    }
    notifyListeners();
  }
}
