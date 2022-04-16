import 'package:flutter/foundation.dart';

class StoreModel {
  final String id;
  final String status;
  final String storeLogo;
  final String storeName;
  final String storeID;
  final String customerID;
  final String dateJoined;
  final String totalFollowers;
  bool isFollow;

  StoreModel({
    @required this.id,
    @required this.status,
    @required this.storeLogo,
    @required this.storeName,
    @required this.storeID,
    @required this.customerID,
    @required this.dateJoined,
    @required this.totalFollowers,
    @required this.isFollow,
  });
}

// class StoreModel {
//   final String storeID;
//   final String customerID;
//   final String storeLogo;
//   final String storeName;
//   final String storeDescription;
//   final String totalFollowers;
//   final List<LiveStreamDataModel> liveStreamDataModel;
//   final List<ProductModel> productModel;
//   bool isFollow;

//   StoreModel({
//     @required this.storeID,
//     @required this.customerID,
//     @required this.storeLogo,
//     @required this.storeName,
//     @required this.storeDescription,
//     @required this.totalFollowers,
//     @required this.liveStreamDataModel,
//     @required this.productModel,
//     @required this.isFollow,
//   });
// }
