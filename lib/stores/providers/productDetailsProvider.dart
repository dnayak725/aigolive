import 'package:aigolive/config/config.dart';
import 'package:aigolive/stores/models/productDetailsModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/productDetailsModel.dart';

class ProductDetailsProvider with ChangeNotifier {
  ProductDetailsModel productDetails = ProductDetailsModel(
    id: "id",
    name: "Please wait..",
    thumbnail: "",
    price: "",
    sellingPrice: "",
    discountPerc: "",
    deliveryFrom: "",
    deliveryInfo: "",
    origin: "",
    description: "",
    brand: "",
    category: "",
    option1: "",
    option2: "",
    unitname: "",
    quantity: "",
    shopAddress: "",
    quantityForAddToCart: 0,
    sellerid: "0",
    variants: [],
  );
  bool isFetching = true;

  fetchData(String productId) async {
    final response = await http.get(
      ApiLinks().getProductDetailsApi + productId,
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
          List<VariantModel> variantsTemp = [];
          var variants = data[0]["variantdetails"];
          variants.forEach((variant) {
            bool flag = true;
            variantsTemp.forEach((element) {
              if (element.variantId == variant["variant_id"].toString()) {
                element.options.add(
                  OptionModel(
                    optionId: variant["option_id"].toString(),
                    optionName: variant["option_name"].toString(),
                    sortOrder: variant["sort_order"].toString(),
                  ),
                );
                flag = false;
              } else {
                flag = true;
              }
            });
            if (flag) {
              variantsTemp.add(
                VariantModel(
                  variantId: variant["variant_id"].toString(),
                  variantName: variant["variant_name"].toString(),
                  options: [
                    OptionModel(
                      optionId: variant["option_id"].toString(),
                      optionName: variant["option_name"].toString(),
                      sortOrder: variant["sort_order"].toString(),
                    )
                  ],
                ),
              );
            }
          });
          double sellPrice = 0.00;
          double actualPrice = 0.00;
          if (data[0]['option_id_1'] != 0 && data[0]['option_id_2'] != 0) {
            sellPrice =
                double.parse(data[0]['variant_selling_price'].toString());
            actualPrice = double.parse(data[0]['variant_price'].toString());
          } else {
            sellPrice =
                double.parse(data[0]['product_selling_price'].toString());
            actualPrice = double.parse(data[0]['baseprice'].toString());
          }
          productDetails = ProductDetailsModel(
            id: data[0]['product_id'].toString(),
            name: data[0]['product_name'].toString(),
            thumbnail: data[0]['product_image'].toString(),
            price: actualPrice.toString(),
            sellingPrice: sellPrice.toString(),
            discountPerc: data[0]['discount'].toString(),
            deliveryInfo: data[0]['deliveryfrom'].toString(),
            deliveryFrom: data[0]['deliveryinfo'].toString(),
            origin: data[0]['product_origin'].toString(),
            description: data[0]['product_description'].toString(),
            brand: data[0]['brand'].toString(),
            category: data[0]['category'].toString(),
            option1: data[0]['option_id_1'].toString(),
            option2: data[0]['option_id_2'].toString(),
            unitname: data[0]["unit_name"].toString(),
            quantity: data[0]["openingquantity"].toString(),
            shopAddress: data[0]["shopaddress"].toString(),
            quantityForAddToCart: 1,
            sellerid: data[0]["sellerid"].toString(),
            variants: variantsTemp,
          );
        }
        isFetching = false;
        break;
      default:
        print("Error " +
            response.statusCode.toString() +
            ": Product details api error");
        break;
    }
    notifyListeners();
  }

  quantityPlus() {
    // if(productDetails.quantityForAddToCart<int.parse(productDetails.quantity))
    productDetails.quantityForAddToCart++;
    notifyListeners();
  }

  quantityMinus() {
    if (productDetails.quantityForAddToCart > 1)
      productDetails.quantityForAddToCart--;
    notifyListeners();
  }

  changeOption1(String id) {
    productDetails.option1 = id;
    fetchProductByVariants();
    notifyListeners();
  }

  changeOption2(String id) {
    productDetails.option2 = id;
    fetchProductByVariants();
    notifyListeners();
  }

  fetchProductByVariants() async {
    final response = await http.get(
      ApiLinks().getProductProceByVariantApi +
          productDetails.id +
          "/" +
          productDetails.option1 +
          "/" +
          productDetails.option2,
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
          productDetails.price = data["actualprice"];
          productDetails.sellingPrice = data["price"];
          productDetails.quantity = data["availablequantity"];
          productDetails.discountPerc = data["discount"];
        }
        break;
      default:
        print(
            "LTPL: product details api error" + response.statusCode.toString());
        break;
    }
    notifyListeners();
  }

  reset() {
    isFetching = true;
    productDetails = ProductDetailsModel(
      id: "id",
      name: "Please wait..",
      thumbnail: "",
      price: "",
      sellingPrice: "",
      discountPerc: "",
      deliveryFrom: "",
      deliveryInfo: "",
      origin: "",
      description: "",
      brand: "",
      category: "",
      option1: "",
      option2: "",
      unitname: "",
      quantity: "",
      shopAddress: "",
      quantityForAddToCart: 0,
      sellerid: "0",
      variants: [],
    );
    notifyListeners();
  }
}
