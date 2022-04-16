import 'package:aigolive/cart/models/cartProductsModel.dart';
import 'package:aigolive/cart/providers/CartProductsProvider.dart';
import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';

class CartProductsHepler extends StatefulWidget {
  final int cartItemId;
  final CartProductsProvider cartProductsProvider;
  final ProductInfo cartProductDetails;
  final int cartItemIndex;
  final int productIndex;
  CartProductsHepler({
    @required this.cartItemId,
    @required this.cartProductsProvider,
    @required this.cartProductDetails,
    @required this.cartItemIndex,
    @required this.productIndex,
  });
  @override
  _CartProductsHeplerState createState() => _CartProductsHeplerState();
}

class _CartProductsHeplerState extends State<CartProductsHepler> {
  MyColors mycolor = new MyColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Checkbox(
            activeColor: MyColors().iconColor,
            value: widget.cartProductDetails.isChecked,
            onChanged: (bool value) {
              widget.cartProductsProvider.setCheckedIndividualProduct(
                widget.cartItemIndex,
                widget.productIndex,
                widget.cartProductDetails.isChecked,
              );
            },
          ),
          Container(
            width: 60,
            height: 60,
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              image: new DecorationImage(
                image: NetworkImage(
                  widget.cartProductDetails.propImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartProductDetails.prodName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  widget.cartProductDetails.optionName1!=""||widget.cartProductDetails.optionName2!=""?
                  Text(
                    widget.cartProductDetails.optionName1 + " | "+widget.cartProductDetails.optionName2,
                    style: TextStyle(fontSize: 12),
                  ):Container(),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'S\$${widget.cartProductDetails.sellPrice}',
                        style: TextStyle(fontSize: 12),
                      ),
                      widget.cartProductDetails.isDiscount
                          ? Text(
                              'S\$${widget.cartProductDetails.actualPrice}',
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                          : SizedBox(),
                      SizedBox(),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.only(
                                  topLeft: Radius
                                      .circular(4),
                                  bottomLeft:
                                  Radius.circular(
                                      4)),
                              color:
                              MyColors().textButton,
                            ),

                            child: IconButton(
                              constraints: BoxConstraints(
                                minHeight: 18.0,
                                maxHeight: 18.0,
                              ),
                              iconSize: 18,
                              splashRadius: 5.0,
                              padding: const EdgeInsets.all(0),
                              color: mycolor.whiteSection,
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                widget.cartProductsProvider
                                    .cartProductQuantityChange(
                                  widget.cartItemIndex,
                                  widget.productIndex,
                                  "subtract",
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 18,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                horizontal: BorderSide(),
                              ),
                            ),
                            child: Text(
                              '${widget.cartProductDetails.quantity}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.only(
                                  topRight: Radius
                                      .circular(4),
                                  bottomRight:
                                  Radius.circular(
                                      4)),
                              color:
                              MyColors().textButton,
                            ),
                            child: IconButton(
                              constraints: BoxConstraints(
                                minHeight: 18.0,
                                maxHeight: 18.0,
                              ),
                              iconSize: 18,
                              splashRadius: 5.0,
                              padding: const EdgeInsets.all(0),
                              color: mycolor.whiteSection,
                              icon: Icon(Icons.add),
                              onPressed: () {
                                widget.cartProductsProvider
                                    .cartProductQuantityChange(
                                  widget.cartItemIndex,
                                  widget.productIndex,
                                  "add",
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
