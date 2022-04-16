import 'package:aigolive/account-setting/likes/models/productModel.dart';
import 'package:aigolive/account-setting/likes/providers/likesProvider.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class LikedProductWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Container(
    //   child: Text("Liked Products list"),
    // );
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Consumer<LikesProvider>(
                builder: (context, likesProvider, child) {
                  List<ProductModel> streamList =
                      likesProvider.likedProductList;
                  print("length: " + streamList.toString());
                  return GridView.count(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    controller: new ScrollController(keepScrollOffset: false),
                    children: List.generate(
                      streamList.length,
                      (index) => Container(
                        child: Column(
                          children: [
                            Stack(children: [
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width - 30) *
                                        .42,
                                height:
                                    (MediaQuery.of(context).size.width - 30) *
                                        .42,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                decoration: new BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                    image: NetworkImage(
                                        streamList[index].imageURL),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ]),

                            //title and session start time
                            Container(
                              // color: Colors.blue,
                              padding:
                                  EdgeInsets.only(left: 0, bottom: 4, top: 4),
                              width: (MediaQuery.of(context).size.width - 30) *
                                  .42,
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
                                            streamList[index].productName,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "\$220.00",
                                            style: TextStyle(
                                                // color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 1,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1, horizontal: 2),
                                            decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: MyColors()
                                                  .orderCancelButtonColor,
                                            ),
                                            child: Text(
                                              '40% off',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Text(
                                          "1.2k sold",
                                          style: TextStyle(fontSize: 8),
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
                    ).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
