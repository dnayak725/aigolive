class PlaceOrderModel {
  final int productID;
  final String productName;
  final String imageURL;
  final double price;
  final double mrpPrice;
  final int availableQuantity;
  int selectedQuantity;
  final List<String> availableColor;
  final List<String> availableSize;
  final String shoppingName;
  final String shoppingAddress;
  final String billingName;
  final String billingAddress;
  final String email;
  final String paymentMethod;

  PlaceOrderModel(
    this.productID,
    this.productName,
    this.imageURL,
    this.price,
    this.mrpPrice,
    this.availableQuantity,
    this.selectedQuantity,
    this.availableColor,
    this.availableSize,
    this.shoppingName,
    this.shoppingAddress,
    this.billingName,
    this.billingAddress,
    this.email,
    this.paymentMethod,
  );
}
