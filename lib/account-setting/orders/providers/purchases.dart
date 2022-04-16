import 'package:flutter/material.dart';
import 'package:aigolive/account-setting/orders/models/purchases_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Purchases with ChangeNotifier {
  List<PurchasesModel> userPurchaseList = [];
  String status = "fetching data.";

  fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("user_id");
    final response = await http.get(
      AppConfig().apiLink + "Customer/FetchOrderList/" + id,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          status = results['status'];
          var data = results['data'];
          List<PurchasesModel> temp = [];
          data.forEach((item) {
            List<OStoreModel> tempStores = [];
            var storeData = item['shoplist'];
            storeData.forEach((store) {
              List<OItemModel> tempItems = [];
              var itemData = store["items"];
              itemData.forEach((item) {
                tempItems.add(OItemModel(
                    item["id"].toString(),
                    item["productId"].toString(),
                    item["product_image"].toString(),
                    item["productname"].toString(),
                    item["option_name"] ?? "",
                    item["option_name2"] ?? "",
                    item["quantity"].toString(),
                    double.parse(item["price"].toString()),
                    item["status"].toString(),
                    item["cancel_reason"].toString(),
                    item["order_number"].toString()));
              });
              tempStores.add(OStoreModel(
                  store["sellerid"].toString(),
                  store["logo"].toString(),
                  store["shopname"].toString(),
                  store["order_notes"].toString(),
                  tempItems));
            });
            temp.add(PurchasesModel(
                item['orderID'].toString(),
                item['orderNo'].toString(),
                item['total_order_value'].toString(),
                item['orderstatus'].toString(),
                item['orderDate'].toString(),
                item['billing_full_name'].toString(),
                item['billing_phone'].toString(),
                item['billing_address'].toString(),
                item['shipping_full_name'].toString(),
                item['shipping_phone'].toString(),
                item['shipping_address'].toString(),
                tempStores));
          });
          if (temp.length > 0)
            userPurchaseList = temp;
          else
            userPurchaseList = [];
        }
        break;

      default:
        print("LTPL: get order api error");
        break;
    }
    notifyListeners();
  }

  List<PurchasesModel> get allToShipPurchasesList {
    List<PurchasesModel> list = [];
    userPurchaseList.forEach((purchase) {
      List<OStoreModel> stores = getStoresByStatus(purchase.stores, "1");
      if (stores.length > 0) {
        PurchasesModel temp = purchase;
        temp.stores = stores;
        list.add(temp);
      }
    });
    return list;
  }

  List<PurchasesModel> get allToReceivePurchasesList {
    List<PurchasesModel> list = [];
    userPurchaseList.forEach((purchase) {
      List<OStoreModel> stores = getStoresByStatus(purchase.stores, "2");
      if (stores.length > 0) {
        PurchasesModel temp = purchase;
        temp.stores = stores;
        list.add(temp);
      }
    });
    return list;
  }

  List<PurchasesModel> get allDeliveredPurchasesList {
    List<PurchasesModel> list = [];
    userPurchaseList.forEach((purchase) {
      List<OStoreModel> stores = getStoresByStatus(purchase.stores, "3");
      if (stores.length > 0) {
        PurchasesModel temp = purchase;
        temp.stores = stores;
        list.add(temp);
      }
    });
    return list;
  }

  List<PurchasesModel> get allCalcelledList {
    List<PurchasesModel> list = [];
    userPurchaseList.forEach((purchase) {
      List<OStoreModel> stores = getStoresByStatus(purchase.stores, "4");
      if (stores.length > 0) {
        PurchasesModel temp = purchase;
        temp.stores = stores;
        list.add(temp);
      }
    });
    return list;
  }

  List<PurchasesModel> get allRefundedList {
    List<PurchasesModel> list = [];
    userPurchaseList.forEach((purchase) {
      List<OStoreModel> stores = getStoresByStatus(purchase.stores, "5");
      if (stores.length > 0) {
        PurchasesModel temp = purchase;
        temp.stores = stores;
        list.add(temp);
      }
    });
    return list;
  }

  List<OStoreModel> getStoresByStatus(
      List<OStoreModel> oStores, String status) {
    List<OStoreModel> tempStore = [];
    oStores.forEach((element) {
      List<OItemModel> items = getOItemsByStatus(element.items, status);
      if (items.length > 0) {
        OStoreModel temp = element;
        temp.items = items;
        tempStore.add(temp);
      }
    });
    return tempStore;
  }

  List<OItemModel> getOItemsByStatus(List<OItemModel> oItems, String status) {
    List<OItemModel> tempItems = [];
    oItems.forEach((item) {
      if (item.status.toString() == status) {
        tempItems.add(item);
      }
    });
    return tempItems;
  }

  // PurchasesModel getOrderById(String id) {
  //   userPurchaseList.forEach((item) {
  //     if (item.orderId == id) {
  //       print(id + " : " + item.orderId);
  //       return item;
  //     }
  //   });
  // }

  reset() {
    userPurchaseList = [];
    status = "logout";
  }

  confirmReceipt(String orderItemId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    final response = await http.put(
      ApiLinks().confirmReceiptApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "CustID": int.parse(userId),
        "ID": int.parse(orderItemId),
      }),
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        fetchData();
        break;
      default:
        print("LTPL: PurchaseCancelOrder api error");
        break;
    }
  }
}
