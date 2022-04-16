import 'package:flutter/foundation.dart';

class MKProductModel {
  final String productID;
  final String productName;
  final String imageURL;
  final String sellingPrice;
  final String productPrice;
  final String discountPerc;
  final String availableQuantity;
  final String sellerId;
  final String productDetailsPageURL;
  final String totalSold;
  MKProductModel(this.productID, this.productName, this.imageURL, this.sellingPrice, this.productPrice, this.discountPerc, this.availableQuantity, this.sellerId, this.productDetailsPageURL,this.totalSold);
}
