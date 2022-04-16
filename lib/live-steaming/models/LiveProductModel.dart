class LiveProductModel {
  final int productID;
  final String productName;
  final String imageURL;
  final double price;
  final double mrpPrice;
  int availableQuantity;
  final List<String> availableColor;
  final List<String> availableSize;

  LiveProductModel(
      this.productID,
      this.productName,
      this.imageURL,
      this.price,
      this.mrpPrice,
      this.availableQuantity,
      this.availableColor,
      this.availableSize);
}
