import 'package:aigolive/account-setting/orders/models/purchases_model.dart';
import 'package:aigolive/account-setting/orders/providers/purchases.dart';
import 'package:aigolive/account-setting/orders/screens/order_cancel_screen.dart';
import 'package:aigolive/account-setting/orders/screens/order_details_screen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:aigolive/stores/models/storeModel.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:aigolive/stores/providers/frontStoreSessionProvider.dart';
import 'package:aigolive/stores/screens/store_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllPurchasesWidget extends StatefulWidget {
  //variables and functions
  final String orderStatusId;

  //constructor
  const AllPurchasesWidget(this.orderStatusId);

  @override
  _AllPurchasesWidgetState createState() => _AllPurchasesWidgetState();
}

class _AllPurchasesWidgetState extends State<AllPurchasesWidget> {
  @override
  Widget build(BuildContext context) {
    // return Container(child: Text("data"),);
    return Consumer<Purchases>(builder: (context, purchases, child) {
      List<PurchasesModel> pList = [];
      // pList = purchases.userPurchaseList;
      if (widget.orderStatusId == "1") {
        pList = purchases.allToShipPurchasesList;
      } else if (widget.orderStatusId == "2") {
        pList = purchases.allToReceivePurchasesList;
      } else if (widget.orderStatusId == "3") {
        pList = purchases.allDeliveredPurchasesList;
      } else if (widget.orderStatusId == "4") {
        pList = purchases.allCalcelledList;
      } else if (widget.orderStatusId == "5") {
        pList = purchases.allRefundedList;
      } else {
        pList = purchases.userPurchaseList;
      }

      return RefreshIndicator(
        onRefresh: _syncData,
        child: Container(
          color: MyColors().lightGrey,
          child: pList.isEmpty
              ? ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // height: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Image.network(
                            'https://cdn.onlinewebfonts.com/svg/img_196624.png',
                            fit: BoxFit.cover,
                            cacheHeight: 70,
                            cacheWidth: 70,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("There are no orders yet.")
                        ],
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 0,
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetailsScreen(
                                          pList[index].orderId)),
                                );
                              },
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      "Order Number #" +
                                          pList[index].orderNum.toString() +
                                          "  ",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_sharp,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  "Paid on " + pList[index].paidOn,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: _shopListWidgets(pList[index].stores,
                                        pList[index].paidOn),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: pList.length,
                ),
        ),
      );
    });
  }

  Future<void> _syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      Provider.of<Purchases>(context, listen: false).fetchData();
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    }
  }

  Widget _getLabelRow(OItemModel orderItemDetails, String paidOn) {
    if (orderItemDetails.status == '5') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(''),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: MyColors().orderCancelButtonColor,
                width: 1.5,
              ),
            ),
            child: Text(
              "Refunded",
              style: TextStyle(color: MyColors().orderCancelButtonColor),
            ),
          ),
        ],
      );
    } else if (orderItemDetails.status == '4') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(''),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: MyColors().orderCancelButtonColor,
                width: 1.5,
              ),
            ),
            child: Text(
              "Cancelled",
              style: TextStyle(color: MyColors().orderCancelButtonColor),
            ),
          ),
        ],
      );
    } else if (orderItemDetails.status == '3') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(''),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: MyColors().deliveredButtonColor,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  "Delivered",
                  style: TextStyle(color: MyColors().deliveredButtonColor),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Text('Total:  '),
          //     Text(
          //       "\$" + orderDetails.unitPrice.toString(),
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     )
          //   ],
          // ),
        ],
      );
    } else if (orderItemDetails.status == '2') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<Purchases>(context, listen: false)
                      .confirmReceipt(orderItemDetails.orderItemId);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: MyColors().deliveredButtonColor,
                  ),
                  child: Text(
                    'Confirm Receipt',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: MyColors().toReceiveButtonColor,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  'To receive',
                  style: TextStyle(color: MyColors().toReceiveButtonColor),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Text('Total:  '),
          //     Text(
          //       "\$" + orderDetails.unitPrice.toString(),
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     )
          //   ],
          // ),
        ],
      );
    } else if (orderItemDetails.status == '1') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderCancelScreen(orderItemDetails, paidOn),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: MyColors().orderCancelButtonColor,
                  ),
                  child: Text(
                    'Cancel Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: MyColors().toShipButtonColor,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  'To ship',
                  style: TextStyle(color: MyColors().toShipButtonColor),
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Text('Total:  '),
          //     Text(
          //       "\$" + orderDetails.unitPrice.toString(),
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     )
          //   ],
          // ),
        ],
      );
    } else {
      return Container();
    }
  }

  _shopListWidgets(List<OStoreModel> store, String paidOn) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: store.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoreDetailsScreen(
                        storeId: store[index].sellerId,
                        storeName: store[index].shopName,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors().iconColor,
                                width: 2.5,
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(store[index].logo),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            store[index].shopName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Visit Shop",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Icon(
                            Icons.chevron_right_sharp,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _orderItemWidgets(store[index].items, paidOn),
            ],
          );
        });
  }

  _orderItemWidgets(List<OItemModel> items, String paidOn) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.all(2),
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                    image: (items[index].image == null ||
                                            items[index].image == "")
                                        ? AssetImage(
                                            'assets/images/noimage.png')
                                        : NetworkImage(items[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 115,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "S\$${items[index].unitPrice}   x ${items[index].quantity}"),
                                      Text(
                                          "S\$${items[index].unitPrice * int.parse(items[index].quantity)}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _getLabelRow(items[index], paidOn),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.end,
                                  //   children: [
                                  //     Text('Total:  '),
                                  //     Text(
                                  //       "\$" + pList[index].price,
                                  //       style: TextStyle(
                                  //           fontWeight:
                                  //               FontWeight.bold),
                                  //     )
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
