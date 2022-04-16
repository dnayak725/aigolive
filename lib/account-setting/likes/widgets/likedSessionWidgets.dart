import 'package:aigolive/account-setting/likes/providers/likesProvider.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class LikedSessionWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 15),
            //   color: mycolor.lightGrey,
            //   child: Column(
            //     children: [
            //       HeadLinkText(
            //         heading: 'Category',
            //         headingAlign: MainAxisAlignment.center,
            //         headColor: mycolor.whiteBgTitle,
            //       ),
            //       SelectSlider()
            //     ],
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Consumer<LikesProvider>(
                builder: (context, likesProvider, child) {
                  List<StreamModel> streamList = likesProvider.likedStreamList;
                  print("lemngth: " + streamList.toString());
                  return GridView.count(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
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
                                    image: AssetImage(streamList[index].img),
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
                                          // width:
                                          //     ((MediaQuery.of(context).size.width -
                                          //                 30) *
                                          //             .4) -
                                          //         20,
                                          child: Text(
                                            streamList[index].title +
                                                " js jk askfasj kbsak bvas erijfj d lvdvdslkjrkj",
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
                                  Container(
                                    child: Text(
                                      "shp name shop name shop name",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                      child: Text(
                                    "105k watched • 2 months ago",
                                    style: TextStyle(fontSize: 8),
                                  )),
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
              // child: FutureBuilder(
              //   // future: getStream(),
              //   builder: (ctxt, snapshot) {
              //     if (snapshot.hasData) {
              //       var item = snapshot.data.streamList;
              //       return GridView.count(
              //         physics: ScrollPhysics(),
              //         shrinkWrap: true,
              //         crossAxisCount: 2,
              //         childAspectRatio: 0.65,
              //         crossAxisSpacing: 10,
              //         controller:
              //             new ScrollController(keepScrollOffset: false),
              //         children: List.generate(
              //           item.length,
              //           (index) => StreamItem(
              //             streamList: item,
              //             index: index,
              //             action: showForm,
              //           ),
              //         ).toList(),
              //       );
              //     } else {
              //       return Center(
              //         child: Container(),
              //       );
              //     }
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
