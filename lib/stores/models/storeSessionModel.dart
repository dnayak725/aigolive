import 'package:aigolive/stores/models/product_model.dart';

class StoreSession {
  final String id;
  final String shopName;
  final String logo;
  final String coverimage;
  final String shopDescription;
  final String numberOfFollowers;
  final FeatureSession featureseSsion;
  final List<ProductModel> storefrontProductList;
  final List<StorefrontSessionList> storefrontSessionList;
  StoreSession({
    this.id,
    this.shopName,
    this.logo,
    this.coverimage,
    this.shopDescription,
    this.numberOfFollowers,
    this.featureseSsion,
    this.storefrontProductList,
    this.storefrontSessionList,
  });
}

class FeatureSession {
  final String id;
  final String featuredSessionname;
  final String description;
  final String videoLink;
  final String pageLink;
  final String watched;
  final String sessionThumbnail;
  final List<ProductModel> productList;
  FeatureSession({
    this.id,
    this.featuredSessionname,
    this.description,
    this.videoLink,
    this.pageLink,
    this.watched,
    this.productList,
    this.sessionThumbnail,
  });
}

class StorefrontSessionList {
  final String id;
  final String sessionName;
  final String sellerId;
  final String sessionThumbnail;
  final String sessionDescription;
  final String watching;
  final String videoLink;
  final String pageLink;
  StorefrontSessionList({
    this.id,
    this.sessionName,
    this.sellerId,
    this.sessionThumbnail,
    this.sessionDescription,
    this.watching,
    this.videoLink,
    this.pageLink,
  });
}
