import 'package:aigolive/landing/models/mostShoppedModel.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/landing/providers/mostShopedProvider.dart';
import 'package:aigolive/landing/widgets/loadingPreview.dart';
import 'package:aigolive/live-steaming/providers/SessionDetailsProductsProvider.dart';
import 'package:aigolive/live-steaming/providers/userMessageProvider.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MostShopedHelper extends StatelessWidget {
  final Axis widgetDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  MostShopedHelper({
    @required this.widgetDirection,
    @required this.crossAxisCount,
    @required this.childAspectRatio,
    @required this.crossAxisSpacing,
    @required this.mainAxisSpacing,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<MostShopedProvider>(
        builder: (context, mostShoppedProvider, child) {
      List<MostShopped> mostShopedList = mostShoppedProvider.mostShopedList;
      var status = mostShoppedProvider.fetchingStatus;
      if (status == 0) {
        return LoadingPreview(
          widgetDirection: widgetDirection,
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        );
      } else {
        return mostShopedList.isNotEmpty
            ? GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: mostShopedList.length,
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
                      await Provider.of<SessionDetailsProductsProvider>(context,
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
                              id: mostShopedList[index].id,
                              sessionId: mostShopedList[index].id,
                              sellerId: mostShopedList[index].sellerId,
                              img: "ffgcf",
                              shopName: mostShopedList[index].shopName,
                              status: "ffgcf",
                              logo: mostShopedList[index].shopLogo,
                              category: "ffgcf",
                              title: mostShopedList[index].sessionName,
                              watching: mostShopedList[index].noOfViews,
                              date: "ffgcf",
                              time: "ffgcf",
                              timePassed: "ffgcf",
                              videoLink: mostShopedList[index].videoLink,
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
                              // width:
                              //     (MediaQuery.of(context).size.width + 10) * .42,
                              height: (MediaQuery.of(context).size.width - 30) *
                                  .42,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    topRight: Radius.circular(7)),
                                // color: Colors.blue,
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                  image: NetworkImage(
                                    mostShopedList[index].sessionThumbnail,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ]),
                          Container(
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
                                        child: Text(
                                          mostShopedList[index].sessionName,
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
                                Container(
                                  child: Text(
                                    mostShopedList[index].shopName,
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
                                Container(
                                  child: Text(
                                    '${mostShopedList[index].noOfViews} Watched',
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
