import 'package:aigolive/landing/models/recommendedModel.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/landing/providers/recommendedProvider.dart';
import 'package:aigolive/landing/widgets/loadingPreview.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class RecommendedHelper extends StatelessWidget {
  final Axis widgetDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  RecommendedHelper({
    @required this.widgetDirection,
    @required this.crossAxisCount,
    @required this.childAspectRatio,
    @required this.crossAxisSpacing,
    @required this.mainAxisSpacing,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendedProvider>(
        builder: (context, recommendedProvider, child) {
      List<Recommended> recomendedList = recommendedProvider.recomendedList;
      var status = recommendedProvider.fetchingStatus;
      if (status == 0) {
        return LoadingPreview(
          widgetDirection: widgetDirection,
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        );
      } else {
        return recomendedList.isNotEmpty
            ? GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: recomendedList.length,
                scrollDirection: widgetDirection,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                ),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveStreamScreen(
                            StreamModel(
                              id: recomendedList[index].id,
                              sessionId: recomendedList[index].sessionId,
                              sellerId: recomendedList[index].sellerId,
                              img: "ffgcf",
                              shopName: recomendedList[index].shopName,
                              status: "ffgcf",
                              logo: recomendedList[index].shopLogo,
                              category: "ffgcf",
                              title: recomendedList[index].sessionName,
                              watching: recomendedList[index].watching,
                              date: "ffgcf",
                              time: "ffgcf",
                              timePassed: "ffgcf",
                              videoLink: recomendedList[index].videoLink,
                            ),
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
                          Stack(children: [
                            Container(
                              // width: (MediaQuery.of(context).size.width + 10) * .42,
                              height: (MediaQuery.of(context).size.width - 30) *
                                  .42,
                              decoration: new BoxDecoration(
                                // color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    topRight: Radius.circular(7)),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                  image: NetworkImage(
                                      recomendedList[index].sessionThumbnail),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 5,
                            //   right: 10,
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //         vertical: 4, horizontal: 6),
                            //     decoration: new BoxDecoration(
                            //       color: Colors.black38,
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(4)),
                            //       // border: Border.all(
                            //       //   color: MyColors().toShipButtonColor,
                            //       //   width: 1.5,
                            //       // ),
                            //     ),
                            //     child: Text(
                            //       "UPCOMING",
                            //       style: TextStyle(
                            //           color: Colors.white, fontSize: 10),
                            //     ),
                            //   ),
                            // ),
                          ]),

                          //title and session start time
                          Container(
                            // color: Colors.blue,
                            padding: EdgeInsets.only(
                                left: 5, bottom: 4, top: 4, right: 3),
                            // width: (MediaQuery.of(context).size.width / 2) - 25,
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
                                          recomendedList[index].sessionName,
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
                                    "${recomendedList[index].shopName}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     GestureDetector(
                                //       onTap: () {
                                //         // Navigator.push(
                                //         //   context,
                                //         //   MaterialPageRoute(
                                //         //       builder: (context) => OrderCancelScreen(orderDetails)),
                                //         // );
                                //       },
                                //       child: Container(
                                //         padding: EdgeInsets.symmetric(
                                //             vertical: 2, horizontal: 6),
                                //         decoration: new BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(30.0),
                                //           color:
                                //               MyColors().orderCancelButtonColor,
                                //         ),
                                //         child: Text(
                                //           'Remind Me',
                                //           style: TextStyle(
                                //               color: Colors.white,
                                //               fontSize: 10),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Container(
                                  child: Text(
                                    "${recomendedList[index].watching} watched",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                heightFactor: 2.5,
                child: Text('No Results Found'),
              );
      }
    });
  }
}
