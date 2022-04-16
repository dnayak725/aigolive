import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:aigolive/account-setting/orders/models/purchases_model.dart';
import 'package:aigolive/account-setting/orders/providers/purchases.dart';
import 'package:aigolive/account-setting/orders/screens/order_cancel_screen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/stores/screens/store_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailsScreen(this.orderId);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().lightGrey,
      appBar: AppBar(
        title: Text('Order Details'),
        centerTitle: true,
        leading: AccountBarPopButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [MyColors().blueDark, MyColors().blueLight],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Consumer<Purchases>(
            builder: (context, purchases, child) {
              List<PurchasesModel> orderDetails = [];
              // print(orderId);
              purchases.userPurchaseList.forEach((item) {
                if (item.orderId == widget.orderId) {
                  orderDetails.add(item);
                }
              });
              if (orderDetails.isEmpty)
                return Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                    // margin: EdgeInsets.only(top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          orderDetails[0].shippingFullName,
                        ),
                        Text(
                          orderDetails[0].shippingPhone,
                        ),
                        Text(
                          'Address -' + orderDetails[0].shippingAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Billing Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          orderDetails[0].billingFullName,
                        ),
                        Text(
                          orderDetails[0].billingPhone,
                        ),
                        Text(
                          'Address -' + orderDetails[0].billingAddress,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 15,
                    color: MyColors().lightGrey,
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 0,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.grey,
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Order Number #" +
                                      orderDetails[0].orderNum.toString() +
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
                              "Paid on " + orderDetails[0].paidOn,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
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
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 15.0),
                                  // margin: EdgeInsets.only(top: 3.0),
                                  child: _shopListWidgets(
                                      orderDetails[0].stores,
                                      orderDetails[0].paidOn),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    color: MyColors().lightGrey,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _shopListWidgets(List<OStoreModel> store, String paidOn) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      // padding: const EdgeInsets.all(8),
      itemCount: store.length,
      itemBuilder: (BuildContext context, int index) {
        // print(store.length);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment:MainAxisAlignment.start,
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
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                children: [
                  Text("Message to Seller:"),
                  SizedBox(width: 5),
                  Expanded(child: Text(store[index].noteForSeller)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _orderItemWidgets(List<OItemModel> items, String paidOn) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          print(items.length);
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
                        // margin: EdgeInsets.only(top: 3.0),
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
                                  items[index].optionName1 != "" &&
                                          items[index].optionName2 != ""
                                      ? Text(
                                          "${items[index].optionName1} | ${items[index].optionName2}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )
                                      : SizedBox(),
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
                                    height: 5,
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

  Widget _getLabelRow(OItemModel orderItemDetails, String paidOn) {
    if (orderItemDetails.status == '5') {
      //refunded widget
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
      //cancelled widget
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
      //delivered widget
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
      //to recieve widget
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
      //to ship widget
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
}
