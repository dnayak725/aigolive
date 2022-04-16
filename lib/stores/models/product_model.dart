import 'package:flutter/foundation.dart';

class ProductModel {
  final String id;
  final String productName;
  final String discount;
  final String image;
  final String sellingPrice;
  final String totalSold;
  final String productPageLink;

  ProductModel({
    @required this.id,
    @required this.productName,
    @required this.discount,
    @required this.image,
    @required this.sellingPrice,
    @required this.totalSold,
    @required this.productPageLink,
  });
}
