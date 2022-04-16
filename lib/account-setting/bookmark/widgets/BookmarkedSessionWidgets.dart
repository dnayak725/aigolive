import 'dart:core';

import 'package:aigolive/account-setting/bookmark/models/bookmarkedSessionModel.dart';
import 'package:aigolive/account-setting/bookmark/providers/bookmarkedSessionProvider.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/live-steaming/models/SessionDetailsProductsModel.dart';
import 'package:aigolive/live-steaming/providers/SessionDetailsProductsProvider.dart';
import 'package:aigolive/live-steaming/providers/userMessageProvider.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class BookmarkedSessionWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookMarkedSessionProvider>(
      builder: (context, bookMarkedSession, child) {
        // print('widget value-'+bookMarkedSession.key);

        List<BookmarkedSessionModel> tempSessionList = [];

        var key = bookMarkedSession.key;

        var regex = new RegExp("($key)", caseSensitive: false);

        bookMarkedSession.bookmarkedSessionList.forEach((element) {
          if (regex.hasMatch(element.shopName)) {
            tempSessionList.add(element);
          }
        });

        // print(tempSessionList.length.toString());

        return Column(
          children: List.generate(
            tempSessionList.length,
            (index) => Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: GestureDetector(
                onTap: () {
                  _clickFunc(tempSessionList[index], context);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 30) * 0.3,
                          child: Container(
                            height: 80,
                            width: 80,
                            margin: EdgeInsets.only(
                              right: 10,
                            ),
                            padding: EdgeInsets.all(20),
                            decoration: new BoxDecoration(
                              color: Colors.white,

                              // shape: BoxShape.circle,

                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    tempSessionList[index].sessionThumbnail),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 30) * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 7),
                                width:
                                    (MediaQuery.of(context).size.width - 30) *
                                        0.7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          ((MediaQuery.of(context).size.width -
                                                      30) *
                                                  0.7) -
                                              50,
                                      child: Text(
                                        tempSessionList[index].sessionName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(tempSessionList[index]
                                            .sessionPageLink);
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.more_vert,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(7),
                                    decoration: new BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),

                                      // color: Colors.white,

                                      shape: BoxShape.circle,

                                      // image: new DecorationImage(

                                      //   fit: BoxFit.contain,

                                      //   image: AssetImage("assets/images/wlogo.png"),

                                      // ),
                                    ),
                                    child: Image.network(
                                      tempSessionList[index].logoUrl,
                                      width: 20,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tempSessionList[index].shopName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        tempSessionList[index].sessionDate +
                                            " • " +
                                            tempSessionList[index].sessionTime,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 8,
                              // ),
                              // Container(
                              //   padding: EdgeInsets.only(left: 7),
                              //   child: Text(
                              //     tempSessionList[index].scheduledDate +
                              //         " | " +
                              //         tempSessionList[index].scheduledTime,
                              //     style: TextStyle(fontSize: 12),
                              //   ),
                              // ),
                              // Container(
                              //   padding: EdgeInsets.only(left: 7),
                              //   child: Text(tempSessionList[index].scheduledTime),
                              // ),
                              // Container(
                              //   padding: EdgeInsets.only(left: 7),
                              //   child: Text(
                              //     tempSessionList[index].categoryList.text,
                              //     style: TextStyle(color: Colors.grey),
                              //   ),
                              // )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  // caption: 'Delete',

                  color: Colors.red,

                  icon: Icons.delete,

                  onTap: () {
                    Provider.of<BookMarkedSessionProvider>(context,
                            listen: false)
                        .removeOrAddSession(tempSessionList[index].sessionId,
                            tempSessionList[index].sellerId, false);
                  },
                ),
              ],
            ),
          ).toList(),
        );
      },
    );
  }

  _clickFunc(
      BookmarkedSessionModel bookmarkedSession, BuildContext context) async {
    await Provider.of<SessionDetailsProductsProvider>(context, listen: false)
        .fetchData(bookmarkedSession.sessionId);
    SessionDetailsProductsModel sessionDetails =
        Provider.of<SessionDetailsProductsProvider>(context, listen: false)
            .sessionDetails;
    await Provider.of<SessionDetailsProductsProvider>(context, listen: false)
        .reset();
    await Provider.of<UserMessageProvider>(context, listen: false).reset();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveStreamScreen(
          StreamModel(
            id: bookmarkedSession.id,
            sessionId: sessionDetails.sessionId,
            sellerId: sessionDetails.sellerId,
            img: "ffgcf",
            shopName: bookmarkedSession.shopName,
            status: "ffgcf",
            logo: bookmarkedSession.logoUrl,
            category: "ffgcf",
            title: sessionDetails.sessionName,
            watching: "34k",
            date: "ffgcf",
            time: "ffgcf",
            timePassed: "ffgcf",
            videoLink: sessionDetails.videoLink,
          ),
        ),
      ),
    );
  }
}
