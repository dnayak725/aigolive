class ProductModel {
  final int productID;
  final String productName;
  final String imageURL;
  final double price;
  final double mrpPrice;
  final double discount;
  int availableQuantity;
  final String webURL;

  ProductModel(
    this.productID,
    this.productName,
    this.imageURL,
    this.price,
    this.mrpPrice,
    this.discount,
    this.availableQuantity,
    this.webURL,
  );
}
