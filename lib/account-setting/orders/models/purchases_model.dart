class PurchasesModel {
   String orderId;
   String orderNum;
   String totalOrderValue;
   String orderstatus;
   String paidOn;
   String billingFullName;
   String billingPhone;
   String billingAddress;
   String shippingFullName;
   String shippingPhone;
   String shippingAddress;
   List<OStoreModel> stores;

  PurchasesModel(this.orderId, this.orderNum, this.totalOrderValue, this.orderstatus, this.paidOn, this.billingFullName, this.billingPhone, this.billingAddress, this.shippingFullName, this.shippingPhone, this.shippingAddress, this.stores);
}

class OStoreModel{
   String sellerId;
   String logo;
   String  shopName;
   String noteForSeller;
   List<OItemModel> items;

  OStoreModel(this.sellerId, this.logo, this.shopName,this.noteForSeller, this.items);
}
class OItemModel {
   String orderItemId;
   String productId;
   String image;
   String name;
   String optionName1;
   String optionName2;
   String quantity;
   double unitPrice;
   String status;
   String cancelReason;
   String orderNum;

  OItemModel(this.orderItemId, this.productId,this.image, this.name, this.optionName1, this.optionName2, this.quantity, this.unitPrice, this.status, this.cancelReason, this.orderNum);
}
