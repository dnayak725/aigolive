import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/marketPlace/models/searchProductListBySearchKeyModel.dart';
import 'package:aigolive/stores/screens/productDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../config/colors.dart';

class BrowsByCategoryHelper extends StatelessWidget {
  final SearchProductListBySearchKeyModel searchResult;

  BrowsByCategoryHelper({
    this.searchResult,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                  searchResult.productId.toString(),
                  searchResult.productName)),
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
              // margin: EdgeInsets.symmetric(
              //   horizontal: 6,
              // ),
              decoration: new BoxDecoration(
                // color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7)),

                shape: BoxShape.rectangle,
                // border: Border.all(width: 1),
                image: new DecorationImage(
                  image: NetworkImage(searchResult.productImage),
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
                            searchResult.productName,
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
                        onTap: () => Share.share("Text here"),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "S\$ ${searchResult.productSellingPrice}",
                            style: TextStyle(
                              color: MyColors().iconColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              color: MyColors().iconColor,
                            ),
                            child: Text(
                              searchResult.discountpercent +" off",
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Text(
                         searchResult.totalSold.toString() + " sold",
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
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
