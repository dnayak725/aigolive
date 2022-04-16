import 'package:aigolive/cart/models/cartProductsModel.dart';
import 'package:aigolive/cart/providers/CartProductsProvider.dart';
import 'package:aigolive/cart/screens/cartScreen.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:aigolive/chat/screens/notificationsScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBar extends StatefulWidget {
  final bool isbackNav;
  final bool isSearchField;
  final bool isSearchIcon;
  final bool isSuffixSearch;
  final bool isPrefixSearch;
  final String subCatSearch;
  final String ifNoSearchStringToDisplay;
  final Color iconColor;
  final Function searchToPage;
  SearchBar({
    this.isbackNav = true,
    this.isSearchField = true,
    this.isSearchIcon = true,
    this.isSuffixSearch = false,
    this.isPrefixSearch = false,
    this.subCatSearch = "",
    this.ifNoSearchStringToDisplay = "",
    this.iconColor = const Color(0xFFFFFFFF),
    this.searchToPage,
  });
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchField = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isbackNav ? AppBarPopButton() : SizedBox(),
          widget.isSearchField
              ? Expanded(
                  child: TextField(
                    controller: searchField,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: widget.subCatSearch,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                        left: 10,
                        right: 0,
                      ),
                      suffixIcon: widget.isSuffixSearch
                          ? GestureDetector(
                              onTap: () {
                                widget.searchToPage(searchField.text);
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.blue[600],
                                size: 22,
                              ),
                            )
                          : SizedBox(),
                      border: _searchBorder(),
                      focusedBorder: _searchBorder(),
                      enabledBorder: _searchBorder(),
                    ),
                  ),
                )
              : Text(widget.ifNoSearchStringToDisplay),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.isSearchIcon
                  ? GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => NotificationsScreen()),
                        // );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.search,
                          color: widget.iconColor,
                          size: 25,
                        ),
                      ),
                    )
                  : SizedBox(),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.containsKey('user_id')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
                  }
                },
                child: Consumer<CartProductsProvider>(
                    builder: (context, cartProductsProvider, child) {
                  List<CartProducts> cartList =
                      cartProductsProvider.cartProductList;
                  int totalCartItems = 0;
                  cartList.forEach((element) {
                    totalCartItems += element.buyerCartLists.length;
                  });
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: widget.iconColor,
                          size: 25,
                        ),
                      ),
                      cartList.length > 0
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.only(top: 1.3),
                                width: 15.5,
                                height: 15.5,
                                child: Text(
                                  "$totalCartItems",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  );
                }),
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.containsKey('user_id')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsScreen()),
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.message_outlined,
                        color: widget.iconColor,
                        size: 25,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 15.5,
                        height: 15.5,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _searchBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue[600],
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    );
  }
}
