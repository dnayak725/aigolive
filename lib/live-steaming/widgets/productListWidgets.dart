import 'package:aigolive/config/colors.dart';
import 'package:aigolive/stores/screens/productDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:aigolive/live-steaming/models/SessionDetailsProductsModel.dart';

class ProductListWidgets extends StatefulWidget {
  final List<SessionDetailsProducts> liveProductList;
  final Function openProductView;

  const ProductListWidgets(
      {Key key, this.liveProductList, this.openProductView})
      : super(key: key);

  @override
  _ProductListWidgetsState createState() => _ProductListWidgetsState();
}

class _ProductListWidgetsState extends State<ProductListWidgets> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return (MediaQuery.of(context).orientation == Orientation.portrait)
        ? KeyboardVisibilityBuilder(builder: (context, visible) {
            return visible
                ? Container()
                : Container(
                    height: 80,
                    margin: EdgeInsets.only(top: 15, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //       vertical: 0.5, horizontal: 4),
                        //   margin: EdgeInsets.only(left: 3, bottom: 3),
                        //   decoration: new BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: Colors.black,
                        //   ),
                        //   child: Text(
                        //     'On Stream',
                        //     style: TextStyle(color: Colors.white, fontSize: 12),
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Container(
                        //       width: 80,
                        //       height: 60,
                        //       child: GestureDetector(
                        //         onTap: () {
                        //           // widget.openProductView(2);
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => ProductDetailsScreen(widget
                        //                     .liveProductList[0].productId,widget
                        //                     .liveProductList[0].productName)),
                        //           );
                        //         },
                        //         child: Container(
                        //           margin: EdgeInsets.only(right: 8),
                        //           padding: EdgeInsets.all(2),
                        //           decoration: new BoxDecoration(
                        //             color: Colors.white,
                        //             shape: BoxShape.rectangle,
                        //             border: Border.all(
                        //               color: MyColors().iconColor,
                        //               width: 3,
                        //             ),
                        //           ),
                        //           child: widget.liveProductList.length > 0
                        //               ? Container(
                        //                   width: 60.0,
                        //                   height: 60.0,
                        //                   decoration: new BoxDecoration(
                        //                     shape: BoxShape.rectangle,
                        //                     image: new DecorationImage(
                        //                       image: NetworkImage(widget
                        //                           .liveProductList[0]
                        //                           .productImage),
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 )
                        //               : SizedBox(),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       color: Colors.white,
                        //       width: 1,
                        //       height: 60,
                        //       margin: EdgeInsets.only(right: 5),
                        //     ),
                        //     Expanded(
                        //       child: Container(
                        //         height: 60,
                        //         child: ListView.builder(
                        //           scrollDirection:
                        //               Axis.horizontal, // <-- Like so
                        //
                        //           itemBuilder: (ctx, index) {
                        //             return GestureDetector(
                        //               onTap: () {
                        //                 Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (context) => ProductDetailsScreen(widget
                        //                           .liveProductList[index].productId,widget
                        //                           .liveProductList[index].productName)),
                        //                 );
                        //                 // setState(() {
                        //                 //   _selectedProduct = index;
                        //                 //   _productsViewMode = 2;
                        //                 // });
                        //                 // widget.openProductView(index);
                        //               },
                        //               child: Container(
                        //                 margin: EdgeInsets.only(right: 8),
                        //                 padding: EdgeInsets.all(2),
                        //                 decoration: new BoxDecoration(
                        //                   color: Colors.white,
                        //                   shape: BoxShape.rectangle,
                        //                   border: Border.all(
                        //                     color: Colors.grey,
                        //                     width: 1,
                        //                   ),
                        //                 ),
                        //                 child: Container(
                        //                   width: 60.0,
                        //                   height: 60.0,
                        //                   decoration: new BoxDecoration(
                        //                     shape: BoxShape.rectangle,
                        //                     image: new DecorationImage(
                        //                       image: NetworkImage(widget
                        //                           .liveProductList[index]
                        //                           .productImage),
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //           itemCount: widget.liveProductList.length,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection:
                            Axis.horizontal, // <-- Like so

                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetailsScreen(widget
                                            .liveProductList[index].productId,widget
                                            .liveProductList[index].productName)),
                                  );
                                  // setState(() {
                                  //   _selectedProduct = index;
                                  //   _productsViewMode = 2;
                                  // });
                                  // widget.openProductView(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  padding: EdgeInsets.all(2),
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: new DecorationImage(
                                        image: NetworkImage(widget
                                            .liveProductList[index]
                                            .productImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: widget.liveProductList.length,
                          ),
                        ),
                      ],
                    ),
                  );
          })
        : Container(
            // color:Colors.deepOrange,
            width: MediaQuery.of(context).size.width * 0.18,
            // height: 60,
            margin: EdgeInsets.only(top: 15, right: 40, left: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 4),
                  margin: EdgeInsets.only(top: 15, bottom: 3),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Text(
                    'On Stream',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Container(
                  width: 80,
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _productsViewMode = 2;
                      // });
                      widget.openProductView(2);
                    },
                    child: Container(
                      // margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: MyColors().iconColor,
                          width: 3,
                        ),
                      ),
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            image: NetworkImage(
                                widget.liveProductList[2].productImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 70,
                  height: 1,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.liveProductList.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   _productsViewMode = 2;
                          // });
                          widget.openProductView(index);
                        },
                        child: Container(
                          width: 70.0,
                          height: 80.0,
                          margin: EdgeInsets.only(
                            bottom: 8,
                          ),
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                image: NetworkImage(
                                    widget.liveProductList[index].productImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
