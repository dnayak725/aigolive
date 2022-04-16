class CartProducts {
  final String sellerId;
  final String shopName;
  final List<ProductInfo> buyerCartLists;
  final double totalOrderValue;
  bool isChecked;
  String message;
  CartProducts({
    this.sellerId,
    this.shopName,
    this.buyerCartLists,
    this.totalOrderValue,
    this.isChecked,
    this.message,
  });
}

class ProductInfo {
  final String optionName1;
  final String optionName2;
  int quantity;
  final String prodName;
  final String propImage;
  final String productId;
  final String cartId;
  final String sessionId;
  final String sessionName;
  final String optionId1;
  final String optionId2;
  final String price;
  final String sellPrice;
  final String actualPrice;
  final bool isDiscount;
  bool isChecked;
  ProductInfo({
    this.optionName1,
    this.optionName2,
    this.quantity,
    this.prodName,
    this.propImage,
    this.productId,
    this.cartId,
    this.sessionId,
    this.sessionName,
    this.optionId1,
    this.optionId2,
    this.price,
    this.sellPrice,
    this.actualPrice,
    this.isDiscount,
    this.isChecked,
  });
}
