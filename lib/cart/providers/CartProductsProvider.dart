import 'dart:convert';
import 'package:aigolive/account-setting/models/addressModel.dart';
import 'package:aigolive/account-setting/orders/screens/my_purchases_screen.dart';
import 'package:aigolive/cart/models/cartProductsModel.dart';
import 'package:aigolive/cart/screens/paymentWebView.dart';
import 'package:aigolive/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartProductsProvider with ChangeNotifier {
  List<CartProducts> cartProductList = [];
  List<CartProducts> checkoutProductList = [];
  List<CartProducts> buyNowProductList = [];
  String listFetchingStatus = "fetching";
  List<ProductInfo> productPerStoreList = [];
  List<ProductInfo> checkoutproductPerStoreList = [];
  List<ProductInfo> buyNowPerStoreList = [];
  bool isAllChecked = false;
  double subTotal = 0.00;
  double totalSavings = 0.00;

  void setCheckedSellerProduct(int checkedSeller, bool checked) {
    int cartItem = cartProductList
        .indexWhere((element) => int.parse(element.sellerId) == checkedSeller);
    cartProductList[cartItem].isChecked = !checked;
    cartProductList[cartItem].buyerCartLists.forEach((element) {
      element.isChecked = !checked;
    });
    bool isAllStoreChecked =
        cartProductList.every((element) => element.isChecked);
    isAllChecked = isAllStoreChecked;
    changePrice();
    notifyListeners();
  }

  void setCheckedIndividualProduct(
      int cartItemIndex, int productIndex, bool checked) {
    cartProductList[cartItemIndex].buyerCartLists[productIndex].isChecked =
        !checked;
    bool isAllProductChecked = cartProductList[cartItemIndex]
        .buyerCartLists
        .every((element) => element.isChecked);
    cartProductList[cartItemIndex].isChecked = isAllProductChecked;
    bool isAllStoreChecked =
        cartProductList.every((element) => element.isChecked);
    isAllChecked = isAllStoreChecked;
    changePrice();
    notifyListeners();
  }

  void setCheckedAllSellerProducts(bool checked) {
    cartProductList.forEach((element) {
      element.isChecked = !checked;
      element.buyerCartLists.forEach((childElement) {
        childElement.isChecked = !checked;
      });
    });
    isAllChecked = !checked;
    changePrice();
    notifyListeners();
  }

  void changePrice() {
    subTotal = 0.00;
    totalSavings = 0.00;
    cartProductList.forEach((cartElement) {
      cartElement.buyerCartLists.forEach((element) {
        if (element.isChecked) {
          subTotal += double.parse(element.sellPrice) * element.quantity;
          totalSavings +=
              (double.parse(element.actualPrice) * element.quantity) -
                  double.parse(element.sellPrice) * element.quantity;
        }
      });
    });
  }

  void changePriceSingle() {
    subTotal = 0.00;
    totalSavings = 0.00;
    buyNowProductList.forEach((cartElement) {
      cartElement.buyerCartLists.forEach((element) {
        if (element.isChecked) {
          subTotal += double.parse(element.sellPrice) * element.quantity;
          totalSavings +=
              (double.parse(element.actualPrice) * element.quantity) -
                  double.parse(element.sellPrice) * element.quantity;
        }
      });
    });
  }

  checkoutItems() {
    checkoutProductList = [];
    checkoutproductPerStoreList = [];
    List<CartProducts> tempProducts = [];
    cartProductList.forEach((cartElement) {
      double orderValuePerSeller = 0.00;
      List<ProductInfo> productPerStoreTemp = [];
      cartElement.buyerCartLists.forEach((element) {
        orderValuePerSeller =
            double.parse(element.sellPrice) * element.quantity;
        if (element.isChecked) {
          productPerStoreTemp.add(
            ProductInfo(
              optionName1: element.optionName1,
              optionName2: element.optionName2,
              quantity: element.quantity,
              prodName: element.prodName,
              propImage: element.propImage,
              productId: element.productId,
              cartId: element.cartId,
              sessionId: element.sessionId,
              sessionName: element.sessionName,
              optionId1: element.optionId1,
              optionId2: element.optionId2,
              price: element.price,
              sellPrice: element.sellPrice,
              actualPrice: element.actualPrice,
            ),
          );
        }
      });
      checkoutproductPerStoreList = productPerStoreTemp;
      if (productPerStoreTemp.length > 0) {
        tempProducts.add(
          CartProducts(
            sellerId: cartElement.sellerId,
            shopName: cartElement.shopName,
            buyerCartLists: checkoutproductPerStoreList,
            totalOrderValue: orderValuePerSeller,
          ),
        );
      }
    });
    checkoutProductList = tempProducts;
  }

  void sellerMessage(int sellerIndex, String message) {
    checkoutProductList[sellerIndex].message = message;
  }

  void cartProductQuantityChange(
      int cartItemIndex, int productIndex, String addOrSubtract) {
    int currentProductQuantity =
        cartProductList[cartItemIndex].buyerCartLists[productIndex].quantity;
    int cartId = int.parse(
        cartProductList[cartItemIndex].buyerCartLists[productIndex].cartId);
    if (addOrSubtract == "add") {
      cartProductList[cartItemIndex].buyerCartLists[productIndex].quantity =
          currentProductQuantity + 1;
      int quantity =
          cartProductList[cartItemIndex].buyerCartLists[productIndex].quantity;
      changeQuantity(cartId, quantity);
    } else {
      if (currentProductQuantity > 1) {
        cartProductList[cartItemIndex].buyerCartLists[productIndex].quantity =
            currentProductQuantity - 1;
        int quantity = cartProductList[cartItemIndex]
            .buyerCartLists[productIndex]
            .quantity;
        changeQuantity(cartId, quantity);
      }
    }
    changePrice();
    notifyListeners();
  }

  changeQuantity(int cartId, int quantity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.put(
      ApiLinks().cartProductQuantityChangeApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "Ccustomer_id": int.parse(sharedPreferences.getString("user_id")),
        "Id": cartId,
        "quantity": quantity,
      }),
    );
    if (response.statusCode == 200) {
      print("Quantity change Sussess");
    } else {
      print("Quantity change Error");
    }
  }

  placeOrder(AddressModel selectedAddress, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = int.parse(pref.getString("user_id"));
    List<Map> orderDetails = [];
    List<Map> orderItemDetails = [];
    checkoutProductList.forEach((cartElement) {
      cartElement.buyerCartLists.forEach((element) {
        orderItemDetails.add({
          "product_id": int.parse(element.productId),
          "VariantId": 0,
          "OptionId1":
              element.optionId1 != "null" ? int.parse(element.optionId1) : 0,
          "OptionId2":
              element.optionId2 != "null" ? int.parse(element.optionId2) : 0,
          "ordercommission": 0.00,
          "session_id": int.parse(element.sessionId),
          "quantity": element.quantity,
          "price": double.parse(element.sellPrice),
          "status": 1
        });
      });
      orderDetails.add({
        "customer_id": userId,
        "seller_id": int.parse(cartElement.sellerId),
        "total_order_value": cartElement.totalOrderValue,
        "status": 0,
        "order_notes": cartElement.message,
        "shipping_address": selectedAddress.address,
        "shipping_fullname": selectedAddress.name,
        "shipping_phonename": selectedAddress.phone,
        "billing_address": selectedAddress.address,
        "billing_phonename": selectedAddress.phone,
        "billing_fullname": selectedAddress.name,
        "ordersitem": orderItemDetails,
      });
    });
    final response = await http.post(
      ApiLinks().placeOrderApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode(orderDetails),
    );
    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      _makePayment(context, results['ordernumber']);
    } else {
      _showAlertDialog("Order Status", "Order Place Error", "Ok", context);
    }
  }

  placeOrderSingle(AddressModel selectedAddress, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = int.parse(pref.getString("user_id"));
    List<Map> orderDetails = [];
    List<Map> orderItemDetails = [];
    buyNowProductList.forEach((cartElement) {
      cartElement.buyerCartLists.forEach((element) {
        orderItemDetails.add({
          "product_id": int.parse(element.productId),
          "VariantId": 0,
          "OptionId1":
              element.optionId1 != "null" ? int.parse(element.optionId1) : 0,
          "OptionId2":
              element.optionId2 != "null" ? int.parse(element.optionId2) : 0,
          "ordercommission": 0.00,
          "session_id": int.parse(element.sessionId),
          "quantity": element.quantity,
          "price": double.parse(element.sellPrice),
          "status": 1
        });
      });
      orderDetails.add({
        "customer_id": userId,
        "seller_id": int.parse(cartElement.sellerId),
        "total_order_value": cartElement.totalOrderValue,
        "status": 0,
        "order_notes": cartElement.message,
        "shipping_address": selectedAddress.address,
        "shipping_fullname": selectedAddress.name,
        "shipping_phonename": selectedAddress.phone,
        "billing_address": selectedAddress.address,
        "billing_phonename": selectedAddress.phone,
        "billing_fullname": selectedAddress.name,
        "ordersitem": orderItemDetails,
      });
    });
    final response = await http.post(
      ApiLinks().placeOrderApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode(orderDetails),
    );
    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      _makePayment(context, results['ordernumber']);
    } else {
      _showAlertDialog("Order Status", "Order Place Error", "Ok", context);
    }
  }

  void sellerMessageSingle(int sellerIndex, String message) {
    buyNowProductList[sellerIndex].message = message;
  }

  _makePayment(BuildContext context, String orderNumber) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map paymentRequest = {
      "email": pref.getString("email"),
      "redirect_url": AppConfig().webLink +
          "Buyers/PaymentSuccess?order_ref=" +
          orderNumber +
          "&totalprice=" +
          subTotal.toStringAsFixed(2),
      "webhook": AppConfig().webLink +
          "Buyers/PaymentSuccess?order_ref=" +
          orderNumber +
          "&totalprice=" +
          subTotal.toStringAsFixed(2),
      "amount": subTotal.toStringAsFixed(2),
      "currency": "SGD"
    };
    final paymentUrlResponse = await http.post(
      ApiLinks().paymentUrlApi,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-BUSINESS-API-KEY":
            "2f350537d1ce028bb2b9d637cc51ba1ce22dd9190b926521b468437fd5401385",
        "X-Requested-With": "XMLHttpRequest",
      },
      body: paymentRequest,
    );
    print("paymentUrlResponse.statusCode ${paymentUrlResponse.statusCode}");
    if (paymentUrlResponse.statusCode == 201) {
      var results = json.decode(paymentUrlResponse.body);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => PaymentWebView(
            url: results['url'],
            redirectUrl: results['redirect_url'],
          ),
        ),
      );
    } else {
      _showAlertDialog("Order Status", "Order Place Error", "Ok", context);
    }
  }

  _showAlertDialog(String alertText, String msg, String buttonText, context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertText),
          content: Text(msg),
          actions: [
            FlatButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MyPurchasesScreen(0, true),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            )
          ],
        );
      },
    );
  }

  removeFromCart(String productId, String optionId1, String optionId2) async {
    print(optionId1);
    print(optionId2);
    var op1 = optionId1 != "null" ? optionId1 : 0;
    var op2 = optionId2 != "null" ? optionId2 : 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = int.parse(pref.getString("user_id"));
    // print(ApiLinks().removeFromCartApi + "/$userId/$productId/$op1/$op2");
    final response = await http.delete(
      ApiLinks().removeFromCartApi + "/$userId/$productId/$op1/$op2",
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    if (response.statusCode == 200) {
      print("cart item delete success");
      fetchData();
    }
  }

  fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var custId = pref.getString("user_id");
    final response = await http.get(
      ApiLinks().cartDetailsApi + "/$custId",
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
          List<CartProducts> temp = [];

          data.forEach((item) {
            List cartProductData = item['buyercartlistsapi'];
            List<ProductInfo> productPerStoreTemp = [];
            cartProductData.forEach((elem) {
              double sellPrice = 0.00;
              double actualPrice = 0.00;
              if (elem['option_id_1'] != null && elem['option_id_2'] != null) {
                sellPrice = elem['sellprice'];
                actualPrice = elem['actualprice'];
              } else {
                sellPrice = elem['basesellingprice'];
                actualPrice = elem['baseprice'];
              }
              productPerStoreTemp.add(
                ProductInfo(
                  optionName1: elem['option_name_1'].toString(),
                  optionName2: elem['option_name_2'].toString(),
                  quantity: elem['quantity'],
                  prodName: elem['product_name'].toString(),
                  propImage: elem['product_image'].toString(),
                  productId: elem['product_id'].toString(),
                  cartId: elem['cartid'].toString(),
                  sessionId: elem['session_id'].toString(),
                  sessionName: elem['session_name'].toString(),
                  optionId1: elem['option_id_1'].toString(),
                  optionId2: elem['option_id_2'].toString(),
                  price: elem['price'].toString(),
                  sellPrice: sellPrice.toStringAsFixed(2),
                  actualPrice: actualPrice.toStringAsFixed(2),
                  isDiscount: actualPrice > sellPrice ? true : false,
                  isChecked: false,
                ),
              );
            });
            productPerStoreList = productPerStoreTemp;
            temp.add(
              CartProducts(
                sellerId: item['sellerid'].toString(),
                shopName: item['shopname'].toString(),
                buyerCartLists: productPerStoreList,
                isChecked: false,
              ),
            );
          });
          cartProductList = temp;
        }
        print("LTPL: Cart api data fetched");
        break;

      default:
        print("LTPL: Cart api error");
        break;
    }
    notifyListeners();
  }
}
