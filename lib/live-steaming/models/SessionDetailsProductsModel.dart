class SessionDetailsProductsModel {
  final String sessionId;
  final String sellerId;
  final String autoSessionid;
  final String sessionThumbnail;
  final String sessionName;
  final String sessionDescription;
  final String createdDate;
  final String videoLink;
  final List<SessionDetailsProducts> products;
  SessionDetailsProductsModel({
    this.sessionId,
    this.sellerId,
    this.autoSessionid,
    this.sessionThumbnail,
    this.sessionName,
    this.sessionDescription,
    this.createdDate,
    this.products,
    this.videoLink,
  });
}

class SessionDetailsProducts {
  final String productId;
  final String sellerId;
  final String productName;
  final String productImage;
  final String productDescription;
  final String productPrice;
  final String productSellingPrice;
  final String discountPercent;
  final String quantity;
  SessionDetailsProducts({
    this.productId,
    this.sellerId,
    this.productName,
    this.productImage,
    this.productDescription,
    this.productPrice,
    this.productSellingPrice,
    this.discountPercent,
    this.quantity,
  });
}
