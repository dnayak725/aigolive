import 'package:aigolive/cart/Helpers/CartProductsHelper.dart';
import 'package:aigolive/cart/models/cartProductsModel.dart';
import 'package:aigolive/cart/providers/CartProductsProvider.dart';
import 'package:aigolive/cart/screens/checkoutScreens.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  MyColors mycolor = new MyColors();
  int cartValue = 1;
  @override
  void initState() {
    super.initState();
    Provider.of<CartProductsProvider>(context, listen: false).fetchData();
    Provider.of<CartProductsProvider>(context, listen: false).isAllChecked =
        false;
    Provider.of<CartProductsProvider>(context, listen: false).subTotal = 0.00;
    Provider.of<CartProductsProvider>(context, listen: false).totalSavings =
        0.00;
    Provider.of<CartProductsProvider>(context, listen: false)
        .checkoutProductList = [];
    Provider.of<CartProductsProvider>(context, listen: false)
        .checkoutproductPerStoreList = [];
  }

  @override
  void dispose() {
    super.dispose();
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
        title: Text("My Cart"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: mycolor.lightGrey,
            padding: EdgeInsets.all(10),
            child: Consumer<CartProductsProvider>(
                builder: (context, cartProductsProvider, child) {
              List<CartProducts> cartList =
                  cartProductsProvider.cartProductList;
              return cartList.length > 0
                  ? Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartList.length,
                        itemBuilder: (ctxt, cartiIndex) {
                          return Card(
                            margin: EdgeInsets.only(
                              bottom:
                                  cartiIndex == cartList.length - 1 ? 30 : 10,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: MyColors().iconColor,
                                      value: cartList[cartiIndex].isChecked,
                                      onChanged: (bool value) {
                                        cartProductsProvider
                                            .setCheckedSellerProduct(
                                          int.parse(
                                            cartList[cartiIndex].sellerId,
                                          ),
                                          cartList[cartiIndex].isChecked,
                                        );
                                      },
                                    ),
                                    Text(
                                      cartList[cartiIndex].shopName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(
                                    parent: NeverScrollableScrollPhysics(),
                                  ),
                                  itemCount: cartList[cartiIndex]
                                      .buyerCartLists
                                      .length,
                                  itemBuilder: (ctxt, cartStoreindex) {
                                    List<ProductInfo> cartStoreList =
                                        cartList[cartiIndex].buyerCartLists;
                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      child: CartProductsHepler(
                                        cartItemId: int.parse(
                                            cartList[cartiIndex].sellerId),
                                        cartProductsProvider:
                                            cartProductsProvider,
                                        cartProductDetails:
                                            cartStoreList[cartStoreindex],
                                        cartItemIndex: cartiIndex,
                                        productIndex: cartStoreindex,
                                      ),
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () {
                                            Provider.of<CartProductsProvider>(
                                                    context,
                                                    listen: false)
                                                .removeFromCart(
                                                    cartStoreList[
                                                            cartStoreindex]
                                                        .productId,
                                                    cartStoreList[
                                                            cartStoreindex]
                                                        .optionId1,
                                                    cartStoreList[
                                                            cartStoreindex]
                                                        .optionId2);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
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
                          Checkbox(
                            activeColor: MyColors().iconColor,
                            value: cartProductsProvidor.isAllChecked,
                            onChanged: (bool value) {
                              cartProductsProvidor.setCheckedAllSellerProducts(
                                  cartProductsProvidor.isAllChecked);
                            },
                          ),
                          Text('All'),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'SubTotal:',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                " \$${cartProductsProvidor.subTotal.toStringAsFixed(2)}",
                                            style: TextStyle(
                                              color: mycolor.iconColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Total Savings:',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                " \$${cartProductsProvidor.totalSavings.toStringAsFixed(2)}",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                FlatButton(
                                  onPressed: () async {
                                    bool anyOneChecked = cartProductsProvidor
                                        .cartProductList
                                        .any((cart) => cart.buyerCartLists.any(
                                            (cartItem) => cartItem.isChecked));
                                    if (anyOneChecked) {
                                      await cartProductsProvidor
                                          .checkoutItems();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckoutScreen(),
                                        ),
                                      );
                                    } else {
                                      _showAlertDialog(
                                          "Alert!",
                                          "Please select a product to place an order",
                                          "Ok",
                                          context);
                                    }
                                  },
                                  color: mycolor.iconColor,
                                  child: Text('Checkout'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox();
            }),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(String alertText, String msg, String buttonText, context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertText),
          content: Text(msg),
          actions: [
            FlatButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
