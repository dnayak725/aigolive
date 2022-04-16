import 'package:aigolive/stores/models/live_stream_data_model.dart';
import 'package:aigolive/stores/screens/sessionDetails.dart';
import 'package:flutter/material.dart';
import 'package:aigolive/stores/models/product_model.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:provider/provider.dart';

class ProductsWidgets extends StatelessWidget {
  final String storeID;

  const ProductsWidgets(this.storeID);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<FollowedStoreProvider>(
        builder: (context, storesObject, child) {
          // print('widget value-'+bookMarkedSession.key);

          var storeDetails =
              storesObject.stores.firstWhere((item) => item.storeID == storeID);
          List<ProductModel> productList = storeDetails.productModel;
          return productList.isEmpty
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(child: Text('0 result')),
                  ],
                )
              : GridView.count(
                  shrinkWrap: true,
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 3,
                  childAspectRatio: 1 / 1.5,
                  // Generate 100 widgets that display their index in the List.
                  physics: new NeverScrollableScrollPhysics(),
                  children: List.generate(productList.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SessionDetails(ProductModel(
                                  id: productList[index].id,
                                  image: productList[index].image,
                                  mrp: productList[index].mrp,
                                  sellingPrice: productList[index].sellingPrice,
                                  discount: productList[index].discount,
                                  sold: productList[index].sold,
                                  productName:
                                      productList[index].productName))),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: SizedBox(
                                child: Container(
                                  // margin: EdgeInsets.symmetric(
                                  //   horizontal: 6,
                                  // ),
                                  width:
                                      (MediaQuery.of(context).size.width - 30) *
                                          0.5,
                                  height:
                                      (MediaQuery.of(context).size.width - 30) *
                                          0.5,
                                  decoration: new BoxDecoration(
                                    // color: Colors.blue,
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                      image: NetworkImage(
                                          productList[index].image),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  // child: Image.asset('assets/images/Apparel-Kids.png',),
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: productList[index]
                                                  .productName
                                                  .length !=
                                              null &&
                                          productList[index]
                                                  .productName
                                                  .length >
                                              35
                                      ? Text(productList[index]
                                              .productName
                                              .substring(0, 35) +
                                          "..")
                                      : Text(productList[index].productName),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                          '\$' +
                                              productList[index]
                                                  .sellingPrice
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '\$' +
                                              productList[index].mrp.toString(),
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    );
                  }),
                );
        },
      ),
    );
  }
}
