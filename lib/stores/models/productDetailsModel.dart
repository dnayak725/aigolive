class ProductDetailsModel {
  String id;
  String name;
  String thumbnail;
  String price;
  String sellingPrice;
  String discountPerc;
  String deliveryInfo;
  String deliveryFrom;
  String origin;
  String description;
  String brand;
  String category;
  String option1;
  String option2;
  String unitname;
  String quantity;
  String shopAddress;
  int quantityForAddToCart;
  String sellerid;
  List<VariantModel> variants;
  ProductDetailsModel({
    this.id,
    this.name,
    this.thumbnail,
    this.price,
    this.sellingPrice,
    this.discountPerc,
    this.deliveryFrom,
    this.deliveryInfo,
    this.origin,
    this.description,
    this.brand,
    this.category,
    this.option1,
    this.option2,
    this.unitname,
    this.quantity,
    this.shopAddress,
    this.quantityForAddToCart,
    this.sellerid,
    this.variants,
  });
}

class VariantModel {
  final String variantId;
  final String variantName;
  List<OptionModel> options;

  VariantModel({
    this.variantId,
    this.variantName,
    this.options,
  });
}

class OptionModel {
  String optionId;
  String optionName;
  String sortOrder;

  OptionModel({
    this.optionId,
    this.optionName,
    this.sortOrder,
  });
}
