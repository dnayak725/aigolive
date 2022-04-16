import 'package:aigolive/cart/models/cartProductsModel.dart';
import 'package:aigolive/cart/providers/CartProductsProvider.dart';
import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';

class CheckoutProductsHelper extends StatefulWidget {
  final int cartItemId;
  final CartProductsProvider cartProductsProvider;
  final ProductInfo cartProductDetails;
  final int cartItemIndex;
  final int productIndex;
  CheckoutProductsHelper({
    @required this.cartItemId,
    @required this.cartProductsProvider,
    @required this.cartProductDetails,
    @required this.cartItemIndex,
    @required this.productIndex,
  });
  @override
  _CheckoutProductsHelperState createState() => _CheckoutProductsHelperState();
}

class _CheckoutProductsHelperState extends State<CheckoutProductsHelper> {
  MyColors mycolor = new MyColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: new BoxDecoration(
              color: Colors.blue,
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
              padding: const EdgeInsets.symmetric(
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
                  widget.cartProductDetails.optionName1 != "" ||
                          widget.cartProductDetails.optionName2 != ""
                      ? Text(
                          widget.cartProductDetails.optionName1 +
                              " | " +
                              widget.cartProductDetails.optionName2,
                          style: TextStyle(fontSize: 12),
                        )
                      : Container(),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '\$${widget.cartProductDetails.sellPrice}',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'x${widget.cartProductDetails.quantity}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '\$${double.parse(widget.cartProductDetails.sellPrice) * widget.cartProductDetails.quantity}',
                        style: TextStyle(fontSize: 12),
                      ),
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
