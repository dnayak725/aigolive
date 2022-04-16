import 'package:aigolive/account-setting/models/addressModel.dart';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/cart/Helpers/CartAddressHelper.dart';
import 'package:aigolive/cart/Helpers/CheckoutProductsHelper.dart';
import 'package:aigolive/cart/models/cartProductsModel.dart';
import 'package:aigolive/cart/providers/CartProductsProvider.dart';
import 'package:aigolive/cart/screens/selectAddressScreen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  MyColors mycolor = new MyColors();
  changeAddressModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
        child: SelectAddress(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarPopButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [mycolor.blueDark, mycolor.blueLight],
            ),
          ),
        ),
        elevation: 0,
        title: Text("Checkout"),
        centerTitle: true,
      ),
      body: Consumer<UserProfileProvider>(
          builder: (context, userProfileProvider, child) {
        List<AddressModel> address = userProfileProvider.addresses;
        int addressDefaultIndex = address.indexWhere(
          (element) =>
              element.id == userProfileProvider.selectedAddress.toString(),
        );
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: mycolor.lightGrey,
              padding: EdgeInsets.all(10),
              child: Consumer<CartProductsProvider>(
                  builder: (context, cartProductsProvider, child) {
                List<CartProducts> cartList =
                    cartProductsProvider.checkoutProductList;
                return cartList.length > 0
                    ? SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Column(
                            children: [
                              addressDefaultIndex >= 0
                                  ? Container(
                                      margin: EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      color: mycolor.whiteSection,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CartAddressHelper(
                                            address:
                                                address[addressDefaultIndex],
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.arrow_right_sharp),
                                            onPressed: () {
                                              changeAddressModal();
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              ListView.builder(
                                physics: ScrollPhysics(
                                  parent: NeverScrollableScrollPhysics(),
                                ),
                                shrinkWrap: true,
                                itemCount: cartList.length,
                                itemBuilder: (ctxt, cartiIndex) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      bottom: cartiIndex == cartList.length - 1
                                          ? 30
                                          : 10,
                                    ),
                                    color: mycolor.whiteSection,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartList[cartiIndex].shopName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(
                                                  parent:
                                                      NeverScrollableScrollPhysics(),
                                                ),
                                                itemCount: cartList[cartiIndex]
                                                    .buyerCartLists
                                                    .length,
                                                itemBuilder:
                                                    (ctxt, cartStoreindex) {
                                                  List<ProductInfo>
                                                      cartStoreList =
                                                      cartList[cartiIndex]
                                                          .buyerCartLists;
                                                  return CheckoutProductsHelper(
                                                    cartItemId: int.parse(
                                                        cartList[cartiIndex]
                                                            .sellerId),
                                                    cartProductsProvider:
                                                        cartProductsProvider,
                                                    cartProductDetails:
                                                        cartStoreList[
                                                            cartStoreindex],
                                                    cartItemIndex: cartiIndex,
                                                    productIndex:
                                                        cartStoreindex,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        DottedBorder(
                                          color: Colors.grey[400],
                                          padding: EdgeInsets.all(10),
                                          strokeWidth: 1,
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text("Message"),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Container(
                                                    height: 40,
                                                    child: TextField(
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "(Optional) Leave a message to the seller",
                                                        hintStyle: TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                        focusedBorder:
                                                            OutlineInputBorder(),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          vertical: 0,
                                                          horizontal: 5,
                                                        ),
                                                      ),
                                                      onChanged:
                                                          (String value) {
                                                        cartProductsProvider
                                                            .sellerMessage(
                                                                cartiIndex,
                                                                value);
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        heightFactor: 2.5,
                        child: Text('No Results Found'),
                      );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<CartProductsProvider>(
                builder: (context, cartProductsProvidor, child) {
                  List<CartProducts> cartList =
                      cartProductsProvidor.cartProductList;
                  return cartList.length > 0
                      ? Container(
                          decoration: BoxDecoration(
                            color: mycolor.whiteSection,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Total Payment:',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "\$${cartProductsProvidor.subTotal.toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: mycolor.iconColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    FlatButton(
                                      onPressed: () {
                                        cartProductsProvidor.placeOrder(
                                            address[addressDefaultIndex],
                                            context);
                                      },
                                      color: mycolor.iconColor,
                                      child: Text('Proceed to Payment'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
