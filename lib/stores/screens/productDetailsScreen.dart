import 'dart:convert';

import 'package:aigolive/cart/models/cartProductsModel.dart';
import 'package:aigolive/cart/providers/CartProductsProvider.dart';
import 'package:aigolive/cart/screens/byuNowCheckoutScreen.dart';
import 'package:aigolive/cart/screens/cartScreen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:aigolive/stores/models/productDetailsModel.dart';
import 'package:aigolive/stores/providers/productDetailsProvider.dart';
import 'package:aigolive/stores/widgets/productDetailsLoadingPreview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/productDetailsModel.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  final String pName;

  const ProductDetailsScreen(this.productId, this.pName);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    Provider.of<ProductDetailsProvider>(context, listen: false)
        .fetchData(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().lightGrey,
      appBar: AppBar(
        title: Consumer<ProductDetailsProvider>(
            builder: (context, productDetailsProvider, child) {
          return Text(
            Provider.of<ProductDetailsProvider>(context, listen: false)
                .productDetails
                .name,
          );
        }),
        centerTitle: true,
        leading: AppBarPopButton(),
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
      body: Consumer<ProductDetailsProvider>(
          builder: (context, productDetailsProvider, child) {
        var pDetails = productDetailsProvider.productDetails;
        List<VariantModel> variants = pDetails.variants;
        return RefreshIndicator(
          onRefresh: () async {
            Provider.of<ProductDetailsProvider>(context, listen: false).reset();
            Provider.of<ProductDetailsProvider>(context, listen: false)
                .fetchData(widget.productId);
          },
          child: productDetailsProvider.isFetching
              ? ProductDetailsLoadingPreview()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: MediaQuery.of(context).size.width - 30,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                              image: NetworkImage(pDetails.thumbnail),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(pDetails.name),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'S\$' + pDetails.sellingPrice,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: MyColors().iconColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1, horizontal: 2),
                                            decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: MyColors().iconColor,
                                            ),
                                            child: Text(
                                              pDetails.discountPerc + ' off',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                            ),
                                          ),
                                          Text('S\$ ' + pDetails.price,
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  variants.length > 0
                                      ? buildVariantWidget(context, pDetails)
                                      : Container(),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Quantity ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 22,
                                              width: 22,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4)),
                                                color: MyColors().textButton,
                                              ),
                                              child: IconButton(
                                                constraints: BoxConstraints(
                                                  minHeight: 18.0,
                                                  maxHeight: 18.0,
                                                ),
                                                iconSize: 18,
                                                splashRadius: 5.0,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                color: MyColors().whiteSection,
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  Provider.of<ProductDetailsProvider>(
                                                          context,
                                                          listen: false)
                                                      .quantityMinus();
                                                },
                                              ),
                                            ),
                                            Container(
                                              height: 22,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                border: Border.symmetric(
                                                  horizontal: BorderSide(),
                                                ),
                                              ),
                                              child: Text(
                                                pDetails.quantityForAddToCart
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 22,
                                              width: 22,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4)),
                                                color: MyColors().textButton,
                                              ),
                                              child: IconButton(
                                                constraints: BoxConstraints(
                                                  minHeight: 18.0,
                                                  maxHeight: 18.0,
                                                ),
                                                iconSize: 18,
                                                splashRadius: 5.0,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                color: MyColors().whiteSection,
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  Provider.of<ProductDetailsProvider>(
                                                          context,
                                                          listen: false)
                                                      .quantityPlus();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          pDetails.quantity.toString() +
                                              ' piece(s) available',
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // _getVariantsWidgets(pDetails),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          addToCart(false);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 12),
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color:
                                                MyColors().toReceiveButtonColor,
                                          ),
                                          child: Text(
                                            'Add to Cart',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Consumer<ProductDetailsProvider>(
                                        builder: (context,
                                            productDetailsProvider, child) {
                                          ProductDetailsModel productDetails =
                                              productDetailsProvider
                                                  .productDetails;
                                          double totalOrderValue = double.parse(
                                                  productDetails.sellingPrice) *
                                              productDetails
                                                  .quantityForAddToCart;
                                          String opName1 = "";
                                          String opName2 = "";
                                          if (productDetails.variants.length >
                                              0) {
                                            productDetails.variants[0].options
                                                .forEach((optionElement) {
                                              if (optionElement.optionId ==
                                                  productDetails.option1) {
                                                opName1 =
                                                    optionElement.optionName;
                                              }
                                            });
                                          }
                                          if (productDetails.variants.length >
                                              1) {
                                            productDetails.variants[1].options
                                                .forEach((optionElement) {
                                              if (optionElement.optionId ==
                                                  productDetails.option2) {
                                                opName2 =
                                                    optionElement.optionName;
                                              }
                                            });
                                          }
                                          return GestureDetector(
                                            onTap: () {
                                              // addToCart(true);

                                              Provider.of<CartProductsProvider>(
                                                      context,
                                                      listen: false)
                                                  .buyNowProductList = [
                                                CartProducts(
                                                  sellerId:
                                                      productDetails.sellerid,
                                                  shopName: "shop name",
                                                  isChecked: true,
                                                  totalOrderValue:
                                                      totalOrderValue,
                                                  buyerCartLists: [
                                                    ProductInfo(
                                                      optionName1: opName1,
                                                      optionName2: opName2,
                                                      quantity: productDetails
                                                          .quantityForAddToCart,
                                                      prodName:
                                                          productDetails.name,
                                                      propImage: productDetails
                                                          .thumbnail,
                                                      productId:
                                                          productDetails.id,
                                                      sessionId: "0",
                                                      sessionName: "",
                                                      optionId1: productDetails
                                                          .option1,
                                                      optionId2: productDetails
                                                          .option2,
                                                      price:
                                                          productDetails.price,
                                                      sellPrice: productDetails
                                                          .sellingPrice,
                                                      actualPrice:
                                                          productDetails.price,
                                                      isChecked: true,
                                                    )
                                                  ],
                                                ),
                                              ];
                                              Provider.of<CartProductsProvider>(
                                                      context,
                                                      listen: false)
                                                  .changePriceSingle();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BuyNowCheckoutScreen(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 12),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                color: MyColors()
                                                    .toShipButtonColor,
                                              ),
                                              child: Text(
                                                'Buy Now',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                right: -10,
                                top: -10,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    size: 20,
                                    // color: Colors,
                                  ),
                                  onPressed: () {
                                    Share.share('Session name is Name1');
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      _deliveryInfo(
                          pDetails.deliveryFrom, pDetails.deliveryInfo),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  "Product Specifications",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              _productSpecificationComponent(
                                  "Category", pDetails.category),
                              SizedBox(
                                height: 3,
                              ),
                              _productSpecificationComponent(
                                  "Brand", pDetails.brand),
                              SizedBox(
                                height: 3,
                              ),
                              _productSpecificationComponent(
                                  "Shop Address", pDetails.shopAddress),
                              SizedBox(
                                height: 3,
                              ),
                              _productSpecificationComponent(
                                  "Product Origin", pDetails.origin),
                            ],
                          ),
                        ),
                      ),
                      _productDescription(pDetails.description)
                    ],
                  ),
                ),
        );
      }),
    );
  }

  buildVariantWidget(BuildContext context, ProductDetailsModel pDetails) {
    List<VariantModel> variants = pDetails.variants;
    return Column(
      children: [
        variants.length > 0
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      variants[0].variantName,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 3,
                        runSpacing: 2,
                        children: [
                          for (var option in variants[0].options)
                            GestureDetector(
                              onTap: () {
                                Provider.of<ProductDetailsProvider>(context,
                                        listen: false)
                                    .changeOption1(option.optionId);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                // margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: option.optionId == pDetails.option1
                                    ? new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Color(0xFF2f5a9e),
                                      )
                                    : new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                child: Text(
                                  option.optionName,
                                  style: TextStyle(
                                      color: option.optionId == pDetails.option1
                                          ? Colors.white
                                          : Color(0xFF2f5a9e),
                                      fontSize: 12),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        variants.length > 1
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      variants[1].variantName,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var option in variants[1].options)
                          GestureDetector(
                            onTap: () {
                              Provider.of<ProductDetailsProvider>(context,
                                      listen: false)
                                  .changeOption2(option.optionId);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              // margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                              decoration: option.optionId == pDetails.option2
                                  ? new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Color(0xFF2f5a9e),
                                    )
                                  : new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                              child: Text(
                                option.optionName,
                                style: TextStyle(
                                    color: option.optionId == pDetails.option2
                                        ? Colors.white
                                        : Color(0xFF2f5a9e),
                                    fontSize: 12),
                              ),
                            ),
                          )
                      ],
                    )),
                  ],
                ),
              )
            : Container(),
      ],
    );
    return variants.length > 0
        ? Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      variants[0].variantName,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<ProductDetailsProvider>(context,
                                listen: false)
                            .changeOption1(variants[0].options[0].optionId);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        decoration:
                            variants[0].options[0].optionId == pDetails.option1
                                ? new BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Color(0xFF2f5a9e),
                                  )
                                : new BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                        child: Text(
                          variants[0].options[0].optionName,
                          style: TextStyle(
                              color: variants[0].options[0].optionId ==
                                      pDetails.option1
                                  ? Colors.white
                                  : Color(0xFF2f5a9e),
                              fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<ProductDetailsProvider>(context,
                                listen: false)
                            .changeOption1(variants[0].options[1].optionId);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        decoration:
                            variants[0].options[1].optionId == pDetails.option1
                                ? new BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Color(0xFF2f5a9e),
                                  )
                                : new BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                        child: Text(
                          variants[0].options[1].optionName,
                          style: TextStyle(
                            color: variants[0].options[1].optionId ==
                                    pDetails.option1
                                ? Colors.white
                                : Color(0xFF2f5a9e),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              variants.length > 1
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            variants[1].variantName,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Provider.of<ProductDetailsProvider>(context,
                                      listen: false)
                                  .changeOption2(
                                      variants[1].options[0].optionId);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: variants[1].options[0].optionId ==
                                      pDetails.option2
                                  ? new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: variants[1].options[0].optionId ==
                                              pDetails.option2
                                          ? Color(0xFF2f5a9e)
                                          : Colors.white,
                                    )
                                  : new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                              child: Text(
                                variants[1].options[0].optionName,
                                style: TextStyle(
                                    color: variants[1].options[0].optionId ==
                                            pDetails.option2
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Provider.of<ProductDetailsProvider>(context,
                                      listen: false)
                                  .changeOption2(
                                      variants[1].options[1].optionId);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: variants[1].options[1].optionId ==
                                      pDetails.option2
                                  ? new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Color(0xFF2f5a9e),
                                    )
                                  : new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                              child: Text(
                                variants[1].options[1].optionName,
                                style: TextStyle(
                                  color: variants[1].options[1].optionId ==
                                          pDetails.option2
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container()
            ],
          )
        : Container();
  }

  _productSpecificationComponent(String attribute, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 60) * 0.4,
          child: Text(attribute,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 60) * 0.6,
          child: Text(
            value,
            style: TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }

  _productDescription(String description) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "Product Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              child: Text(description),
            )
          ],
        ),
      ),
    );
  }

  _deliveryInfo(String deliveryFrom, String deliveryInfo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 60) * 0.4,
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/to_ship.png",
                          height: 20,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Deliver from",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: (MediaQuery.of(context).size.width - 60) * 0.6,
                    child: Text(deliveryFrom)),
              ],
            ),
            Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 60) * 0.4,
                  child: Row(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/delivery_info.png",
                          height: 20,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Delivery Info",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: (MediaQuery.of(context).size.width - 60) * 0.6,
                    child: Text(deliveryInfo)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addToCart(bool isBuyNow) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId;
    if (sharedPreferences.containsKey('user_id')) {
      userId = sharedPreferences.getString("user_id");
      // print("LTPL: profile data fetched");
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    }
    ProductDetailsModel productDetails =
        Provider.of<ProductDetailsProvider>(context, listen: false)
            .productDetails;
    final response = await http.post(
      ApiLinks().addToCartApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "customer_id": int.parse(userId),
        "product_id": int.parse(productDetails.id),
        "variant_id": 0,
        "option_id_1": productDetails.option1 == ""
            ? 0
            : int.parse(productDetails.option1),
        "option_id_2": productDetails.option2 == ""
            ? 0
            : int.parse(productDetails.option2),
        "session_id": 0,
        "sellerid": int.parse(productDetails.sellerid),
        "quantity": productDetails.quantityForAddToCart,
        "price": double.parse(productDetails.price)
      }),
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          var data = results['data'];
          if (isBuyNow) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Success!!"),
                  content: Text("Added to cart."),
                  actions: [
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
          }
          // productDetails.price=data["actualprice"];
          // productDetails.sellingPrice=data["price"];
          // productDetails.quantity=data["availablequantity"];
          // productDetails.discountPerc=data["discount"];
        }
        break;
      default:
        print(
            "LTPL: product details api error" + response.statusCode.toString());
        break;
    }
  }
}
