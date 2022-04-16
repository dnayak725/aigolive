import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/models/comingUpNextModel.dart';
import 'package:aigolive/landing/models/newThisWeekModel.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/landing/providers/comingUpNextProvider.dart';
import 'package:aigolive/landing/providers/onAirStreamsProvider.dart';
import 'package:aigolive/landing/widgets/loadingPreview.dart';
import 'package:aigolive/live-steaming/providers/SessionDetailsProductsProvider.dart';
import 'package:aigolive/live-steaming/providers/userMessageProvider.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class StreamSliderHelp extends StatelessWidget {
  final Axis widgetDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  StreamSliderHelp({
    @required this.widgetDirection,
    @required this.crossAxisCount,
    @required this.childAspectRatio,
    @required this.crossAxisSpacing,
    @required this.mainAxisSpacing,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<OnAirStreamsProvider>(
      builder: (context, newThisWeek, child) {
        List<NewThisWeek> newThisWeekList = newThisWeek.newThisWeek;
        int status = newThisWeek.isFetching;
        if (status == 0) {
          return LoadingPreview(
            widgetDirection: widgetDirection,
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
          );
        } else {
          return newThisWeekList.isNotEmpty
              ? GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newThisWeekList.length,
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
                        await Provider.of<SessionDetailsProductsProvider>(
                                context,
                                listen: false)
                            .reset();
                        await Provider.of<UserMessageProvider>(context,
                                listen: false)
                            .reset();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LiveStreamScreen(
                              StreamModel(
                                id: newThisWeekList[index].id,
                                sessionId: newThisWeekList[index].sessionId,
                                sellerId: newThisWeekList[index].sellerId,
                                img: "ffgcf",
                                shopName: newThisWeekList[index].shopName,
                                status: "ffgcf",
                                logo: newThisWeekList[index].shopLogo,
                                category: "ffgcf",
                                title: newThisWeekList[index].sessionName,
                                watching: newThisWeekList[index].watching,
                                date: "ffgcf",
                                time: "ffgcf",
                                timePassed: "ffgcf",
                                videoLink: newThisWeekList[index].videoLink,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  // width:
                                  //     (MediaQuery.of(context).size.width + 10) *
                                  //         .42,
                                  height:
                                      (MediaQuery.of(context).size.width - 30) *
                                          .42,
                                  // margin: EdgeInsets.symmetric(
                                  //   horizontal: 6,
                                  // ),
                                  decoration: new BoxDecoration(
                                    // color: Colors.blue,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        topRight: Radius.circular(7)),
                                    image: new DecorationImage(
                                      image: NetworkImage(newThisWeekList[index]
                                          .sessionThumbnail),
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
                                //       borderRadius: BorderRadius.all(
                                //         Radius.circular(4),
                                //       ),
                                //     ),
                                //     child: Text(
                                //       "UPCOMING",
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 10,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, bottom: 4, top: 4, right: 3),
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
                                            newThisWeekList[index].sessionName,
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
                                        onTap: () => Share.share(
                                            newThisWeekList[index].pageLink),
                                        child: Icon(
                                          Icons.more_vert,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Text(
                                      newThisWeekList[index].shopName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 2,
                                  // ),
                                  // Container(
                                  //   child: index == 0
                                  //       ? Text(
                                  //           "Tomorrow, 2:30pm",
                                  //           style: TextStyle(fontSize: 10),
                                  //         )
                                  //       : Text(
                                  //           "Today, 2:30pm",
                                  //           style: TextStyle(fontSize: 10),
                                  //         ),
                                  // ),
                                  // SizedBox(
                                  //   height: 2,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  //           vertical: 2,
                                  //           horizontal: 6,
                                  //         ),
                                  //         decoration: new BoxDecoration(
                                  //           borderRadius: BorderRadius.all(
                                  //             Radius.circular(4),
                                  //           ),
                                  //           color: MyColors().orderCancelButtonColor,
                                  //         ),
                                  //         child: Text(
                                  //           'Remind Me',
                                  //           style: TextStyle(
                                  //             color: Colors.white,
                                  //             fontSize: 10,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
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
      },
    );
  }
}
