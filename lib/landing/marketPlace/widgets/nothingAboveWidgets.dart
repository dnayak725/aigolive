import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/marketPlace/models/MKProductModel.dart';
import 'package:aigolive/landing/marketPlace/providers/NothingAboveProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/weeklyDealsProovider.dart';
import 'package:aigolive/landing/widgets/loadingPreview.dart';
import 'package:aigolive/stores/providers/productDetailsProvider.dart';
import 'package:aigolive/stores/screens/productDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NothingAboveWidgets extends StatelessWidget {
  final Axis widgetDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const NothingAboveWidgets({
    Key key,
    this.widgetDirection,
    this.crossAxisCount,
    this.childAspectRatio,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NothingAboveProvider>(
      builder: (context, nothingAboveProvider, child) {
        List<MKProductModel> productList =
            nothingAboveProvider.nothingAboveProductList;
        var status = nothingAboveProvider.listFetchingStatus;
        if (status == "fetching") {
          return LoadingPreview(
            widgetDirection: widgetDirection,
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
          );
        } else {
          return productList.isEmpty
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(child: Text('0 results found!')),
                  ],
                )
              : GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: productList.length,
                  scrollDirection: widgetDirection,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: mainAxisSpacing,
                  ),
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () async {
                        await Provider.of<ProductDetailsProvider>(context, listen: false).reset();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                  productList[index].productID,
                                  productList[index].productName)),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              // width: (MediaQuery.of(context).size.width + 10) *
                              //     .42,
                              height: (MediaQuery.of(context).size.width - 40) *
                                  .42,
                              decoration: new BoxDecoration(
                                // border: Border.all(width: 1),
                                // color: Colors.blue,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                  image:
                                      NetworkImage(productList[index].imageURL),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            //title and product price start time
                            Container(
                              // color: Colors.blue,
                              padding: EdgeInsets.only(left: 5, bottom: 4, top: 4, right: 3),
                              // width:
                              //     (MediaQuery.of(context).size.width / 2) - 25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            productList[index].productName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "S\$ " +
                                                productList[index].sellingPrice,
                                            style: TextStyle(
                                                color: MyColors().iconColor,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            width: 0.5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1, horizontal: 2),
                                            decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: MyColors()
                                                  .iconColor,
                                            ),
                                            child: Text(
                                              productList[index].discountPerc +
                                                  ' off',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 3),
                                        child: Text(
                                          productList[index].totalSold+ " sold",
                                          style: TextStyle(
                                              // color: Colors.white,
                                              fontSize: 8),
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
                  },
                );
        }
      },
    );
  }
}
