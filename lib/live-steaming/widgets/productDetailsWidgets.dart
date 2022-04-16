import 'package:aigolive/live-steaming/models/LiveProductModel.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidgets extends StatefulWidget {
  final int initialPage;
  final Function productListMode;
  final Function productPurchaseMode;
  final List<LiveProductModel> liveProductList;
  final CarouselController _carouselController;

  const ProductDetailsWidgets(this.initialPage, this.productListMode,
      this.productPurchaseMode, this.liveProductList, this._carouselController);
  @override
  _ProductDetailsWidgetsState createState() => _ProductDetailsWidgetsState();
}

class _ProductDetailsWidgetsState extends State<ProductDetailsWidgets> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 10 / 7,

          enableInfiniteScroll: false,
          initialPage: widget.initialPage,
          // autoPlay: false,
        ),
        items: widget.liveProductList
            .map((item) => Container(
                  height: 400,
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: SingleChildScrollView(
                        child: Stack(children: [
                          SizedBox(
                            // margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          bottom: 8,
                                          top: 18),
                                      padding: EdgeInsets.all(2),
                                      decoration: new BoxDecoration(
                                        // color: Colors.white,
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
                                            image: NetworkImage(item.imageURL),
                                            // 'https://5.imimg.com/data5/VB/HN/GLADMIN-12117779/samsung-washing-machine-wt655qpndrp-500x500.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        // color: Colors.red,
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.productName,
                                              // style: TextStyle(fontSize: 18),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    '\$' +
                                                        item.mrpPrice
                                                            .toStringAsFixed(2),
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    '\$' +
                                                        item.price.toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            item.availableColor.isEmpty
                                                ? Container()
                                                : Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Color',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        12),
                                                            decoration:
                                                                new BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.0),
                                                              color: Color(
                                                                  0xFF2f5a9e),
                                                            ),
                                                            child: Text(
                                                              'Blue',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 3,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              new BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.5,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Black',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            item.availableSize.isEmpty
                                                ? Container()
                                                : Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Size',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        8),
                                                            decoration:
                                                                new BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xFF2f5a9e),
                                                            ),
                                                            child: Text(
                                                              'S',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        4),
                                                            decoration:
                                                                new BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.5,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'M',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        4),
                                                            decoration:
                                                                new BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              // borderRadius: BorderRadius.circular(30.0),
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.5,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              ' L ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        4),
                                                            decoration:
                                                                new BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.5,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'XL',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 4),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Quantity ',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // if (_quantity > 1) {
                                                      // setState(() {
                                                      // _quantity--;
                                                      // });
                                                      // }
                                                    },
                                                    child: Container(
                                                      height: 22,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration:
                                                          new BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                          bottom: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                          left: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                          right: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 22,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6,
                                                            vertical: 2),
                                                    decoration:
                                                        new BoxDecoration(
                                                      border: Border(
                                                        // left: BorderSide.none,
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                        bottom: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                        // color: Colors.black,
                                                        // width: 1.5,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      '1',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        // _quantity++;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 22,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration:
                                                          new BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                          bottom: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                          left: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                          right: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              item.availableQuantity
                                                      .toString() +
                                                  ' piece available',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  widget.productPurchaseMode();
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 8),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 12),
                                                decoration: new BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  color: Color(0xFF13264c),
                                                  border: Border.all(
                                                    color: Color(0xFF13264c),
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  'Buy Now',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -10,
                            top: -10,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 20,
                                // color: Colors,
                              ),
                              onPressed: () {
                                widget.productListMode();
                              },
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
