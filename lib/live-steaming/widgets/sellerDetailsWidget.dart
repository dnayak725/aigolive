import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/live-steaming/providers/SessionDetailsProductsProvider.dart';
import 'package:aigolive/live-steaming/providers/video_player_provider.dart';
import 'package:aigolive/stores/models/storeModel.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerDetailsWidgets extends StatefulWidget {
  final Function rotateTheScreen;
  final StreamModel streamDetails;

  const SellerDetailsWidgets(this.rotateTheScreen, this.streamDetails);

  @override
  _SellerDetailsWidgetsState createState() => _SellerDetailsWidgetsState();
}

class _SellerDetailsWidgetsState extends State<SellerDetailsWidgets> {
  syncData() async {
    await Provider.of<FollowedStoreProvider>(context, listen: false)
        .getLocalUserId();
  }

  @override
  void initState() {
    super.initState();
    syncData();
  }

  @override
  Widget build(BuildContext context) {
    return (MediaQuery.of(context).orientation == Orientation.portrait)
        ? Container(
            // width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 30, left: 15, right: 15),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

            // color: Colors.black26,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Container(
                  child: Text(
                    widget.streamDetails.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(20),
                            decoration: new BoxDecoration(
                              // border: Border.all(
                              //   color: Colors.red,
                              //   width: 2.5,
                              // ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(widget.streamDetails.logo),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  widget.streamDetails.shopName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Icon(
                              //       Icons.remove_red_eye_outlined,
                              //       color: Colors.white,
                              //       size: 14,
                              //     ),
                              //     Text(
                              //       Provider.of<VideoPlayerProvider>(
                              //             context,
                              //           ).totalViewers.toString() +
                              //           ' Viewers',
                              //       style: TextStyle(
                              //           color: Colors.white, fontSize: 12),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Consumer<FollowedStoreProvider>(
                      builder: (context, followedStores, child) {
                        var localUserId = followedStores.localUserId;
                        List<StoreModel> allStores = followedStores.stores;
                        if (localUserId != null) {
                          bool isFollowed = allStores.any((element) =>
                              element.storeID == widget.streamDetails.sellerId);
                          return InkWell(
                            onTap: () {
                              if (isFollowed) {
                                Provider.of<FollowedStoreProvider>(context,
                                        listen: false)
                                    .unfollowStore(
                                        widget.streamDetails.sellerId,
                                        localUserId,
                                        false);
                              } else {
                                Provider.of<FollowedStoreProvider>(context,
                                        listen: false)
                                    .unfollowStore(
                                        widget.streamDetails.sellerId,
                                        localUserId,
                                        true);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: isFollowed
                                    ? MyColors().iconColor
                                    : Color(0xFF13264c),
                                border: Border.all(
                                  color: isFollowed
                                      ? MyColors().iconColor
                                      : Color(0xFF13264c),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    isFollowed ? 'Following' : 'Follow',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                    // IconButton(
                    //   color: Colors.white,
                    //   icon: Icon(Icons.screen_rotation_rounded),
                    //   onPressed: () {
                    //     widget.rotateTheScreen();
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            // width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WOMEN WEAR MIXED',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Row(
                      children: [
                        IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.screen_rotation_rounded),
                          onPressed: () {
                            widget.rotateTheScreen();
                          },
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.red,
                            border: Border.all(
                              color: Colors.red,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            'Live',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(20),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/images/wlogo.png"),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(
                                'Shop Name:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.remove_red_eye_outlined,
                            //       color: Colors.white,
                            //       size: 14,
                            //     ),
                            //     Text(
                            //       '100 Viewers',
                            //       style: TextStyle(
                            //           color: Colors.white, fontSize: 12),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                    Consumer<FollowedStoreProvider>(
                      builder: (context, followedStores, child) {
                        var localUserId = followedStores.localUserId;
                        List<StoreModel> allStores = followedStores.stores;
                        if (localUserId != null) {
                          bool isFollowed = allStores.any((element) =>
                              element.storeID == widget.streamDetails.sellerId);
                          return InkWell(
                            onTap: () {
                              if (isFollowed) {
                                Provider.of<FollowedStoreProvider>(context,
                                        listen: false)
                                    .unfollowStore(
                                        widget.streamDetails.sellerId,
                                        localUserId,
                                        false);
                              } else {
                                Provider.of<FollowedStoreProvider>(context,
                                        listen: false)
                                    .unfollowStore(
                                        widget.streamDetails.sellerId,
                                        localUserId,
                                        true);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: isFollowed
                                    ? MyColors().iconColor
                                    : Color(0xFF13264c),
                                border: Border.all(
                                  color: isFollowed
                                      ? MyColors().iconColor
                                      : Color(0xFF13264c),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    isFollowed ? 'Following' : 'Follow',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
