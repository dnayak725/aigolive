import 'package:aigolive/config/config.dart';
import 'package:aigolive/stores/models/product_model.dart';
import 'package:aigolive/stores/models/storeSessionModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FrontStoreSessionProvider with ChangeNotifier {
  StoreSession storeSessionData = StoreSession();
  List<StorefrontSessionList> storeSessionList = [];
  List<ProductModel> storeProductList = [];
  int activeSessionFilterIndex = 0;
  int activeProductFilterIndex = 0;
  int fetchStatus = 0;
  String priceOrder = "ASC";

  void filterSessions(filterValue, filterIndex) {
    switch (filterValue) {
      case "Popular":
        Comparator<StorefrontSessionList> viewComparator =
            (a, b) => int.parse(b.watching).compareTo(int.parse(a.watching));
        storeSessionList.sort(viewComparator);
        break;
      default:
        Comparator<StorefrontSessionList> idComparator =
            (a, b) => int.parse(a.id).compareTo(int.parse(b.id));
        storeSessionList.sort(idComparator);
    }
    activeSessionFilterIndex = filterIndex;
    notifyListeners();
  }

  void filterProducts(filterValue, filterIndex) {
    switch (filterValue) {
      case "Recent":
        Comparator<ProductModel> idComparator =
            (a, b) => int.parse(b.id).compareTo(int.parse(a.id));
        storeProductList.sort(idComparator);
        break;
      case "Price":
        Comparator<ProductModel> priceComparator;
        if (priceOrder == "ASC") {
          priceComparator = (a, b) => double.parse(a.sellingPrice)
              .compareTo(double.parse(b.sellingPrice));
          priceOrder = "DESC";
        } else {
          priceComparator = (b, a) => double.parse(a.sellingPrice)
              .compareTo(double.parse(b.sellingPrice));
          priceOrder = "ASC";
        }
        storeProductList.sort(priceComparator);
        break;
      default:
        Comparator<ProductModel> idComparator =
            (a, b) => int.parse(a.id).compareTo(int.parse(b.id));
        storeProductList.sort(idComparator);
    }
    activeProductFilterIndex = filterIndex;
    notifyListeners();
  }

  fetchData(String sellerId) async {
    final response = await http.get(
      ApiLinks().fetchFrontStoreSessionApi + "/$sellerId",
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
          // print(data);
          if (data.isNotEmpty) {
            List storefrontProductList = data[0]["storefrontproductlist"];
            List<ProductModel> tempStorefrProdList = [];
            storefrontProductList.forEach((prodList) {
              tempStorefrProdList.add(
                ProductModel(
                  id: prodList['id'].toString(),
                  productName: prodList['productname'].toString(),
                  discount: prodList['discountpercent'].toString(),
                  image: prodList['propimage'].toString(),
                  sellingPrice: prodList['product_selling_price'].toString(),
                  totalSold: prodList['total_product_sold'].toString(),
                  productPageLink: prodList['productpagelink'].toString(),
                ),
              );
            });
            storeProductList = tempStorefrProdList;
            List storefrontSessionList = data[0]["storefrontsessionlist"];
            List<StorefrontSessionList> tempStorefrSessList = [];
            storefrontSessionList.forEach((sessList) {
              tempStorefrSessList.add(
                StorefrontSessionList(
                  id: sessList['id'].toString(),
                  sessionName: sessList['session_name'].toString(),
                  sellerId: sessList['sellerId'].toString(),
                  sessionThumbnail: sessList['session_thumbnail'].toString(),
                  sessionDescription:
                      sessList['session_description'].toString(),
                  watching: sessList['watching'].toString(),
                  videoLink: sessList['videolink'].toString(),
                  pageLink: sessList['pagelink'].toString(),
                ),
              );
            });
            storeSessionList = tempStorefrSessList;
            Comparator<StorefrontSessionList> viewComparator = (a, b) =>
                int.parse(b.watching).compareTo(int.parse(a.watching));
            storeSessionList.sort(viewComparator);
            storeSessionData = StoreSession(
              id: data[0]['id'].toString(),
              shopName: data[0]['shopName'].toString(),
              logo: data[0]['logo'].toString(),
              coverimage: data[0]['coverimage'].toString(),
              shopDescription: data[0]['shoP_DESCRIPTION'].toString(),
              numberOfFollowers: data[0]['numberoffollowers'].toString(),
              featureseSsion: FeatureSession(
                id: data[0]["featuresessionlist"][0]['id'].toString(),
                featuredSessionname: data[0]["featuresessionlist"][0]
                        ['featuredsessionname']
                    .toString(),
                description:
                    data[0]["featuresessionlist"][0]['description'].toString(),
                videoLink:
                    data[0]["featuresessionlist"][0]['videolink'].toString(),
                pageLink:
                    data[0]["featuresessionlist"][0]['pagelink'].toString(),
                watched: data[0]["featuresessionlist"][0]['watched'].toString(),
                sessionThumbnail: data[0]["featuresessionlist"][0]
                        ['sessionthumbnail']
                    .toString(),
              ),
              storefrontProductList: tempStorefrProdList,
              storefrontSessionList: tempStorefrSessList,
            );
          }
        }
        print("LTPL: FrontStoreSessionApi api data fetched");
        break;

      default:
        print("LTPL: FrontStoreSessionApi api error");
        break;
    }
    fetchStatus=response.statusCode;
    notifyListeners();
  }

  reset() {
    storeSessionList = [];
    storeProductList = [];
    activeProductFilterIndex = 0;
    fetchStatus = 0;
    priceOrder = "ASC";
  }
}
