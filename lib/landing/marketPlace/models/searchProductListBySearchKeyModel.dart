class SearchProductListBySearchKeyModel {
  final int productId;
  final String sellerId;
  final String productName;
  final String productImage;
  final String productDescription;
  final double productPrice;
  final String productSellingPrice;
  final String discountpercent;
  final String quantity;
  final String totalSold;
  SearchProductListBySearchKeyModel({
    this.productId,
    this.sellerId,
    this.productName,
    this.productImage,
    this.productDescription,
    this.productPrice,
    this.productSellingPrice,
    this.discountpercent,
    this.quantity,
    this.totalSold
  });
}
