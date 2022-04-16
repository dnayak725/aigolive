import 'package:aigolive/config/colors.dart';
import 'package:aigolive/stores/models/product_model.dart';
import 'package:aigolive/stores/models/storeSessionModel.dart';
import 'package:aigolive/stores/screens/productDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class StoreProductWidget extends StatelessWidget {
  final StoreSession storeDetails;
  final ProductModel productDetails;

  StoreProductWidget({
    @required this.storeDetails,
    @required this.productDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              productDetails.id,
              productDetails.productName,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              // width: (MediaQuery.of(context).size.width + 10) * .42,
              height: (MediaQuery.of(context).size.width - 30) * .42,
              decoration: new BoxDecoration(
                // color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                  image: NetworkImage(productDetails.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            //title and session start time
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(left: 5, bottom: 4, top: 4, right: 3),
              // width: (MediaQuery.of(context).size.width / 2) - 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            productDetails.productName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Share.share(productDetails.productPageLink),
                        child: Icon(
                          Icons.more_vert,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "S\$${productDetails.sellingPrice}",
                            style: TextStyle(
                                color: MyColors().iconColor, fontSize: 14),
                          ),
                          SizedBox(width: 2),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 1,
                              horizontal: 2,
                            ),
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: MyColors().iconColor,
                            ),
                            child: Text(
                              "${productDetails.discount} off",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${productDetails.totalSold} sold",
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
