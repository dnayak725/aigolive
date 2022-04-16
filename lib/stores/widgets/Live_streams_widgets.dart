// import 'package:aigolive/account-setting/bookmark/models/bookmarkedSessionModel.dart';
// import 'package:aigolive/account-setting/bookmark/models/categoryModel.dart';
// import 'package:aigolive/account-setting/bookmark/providers/bookmarkedSessionProvider.dart';
// import 'package:aigolive/config/colors.dart';
// import 'package:aigolive/stores/models/live_stream_data_model.dart';
// import 'package:aigolive/stores/models/storeModel.dart';
// import 'package:aigolive/stores/providers/followedStoresProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:share/share.dart';

// class LiveStreamsWidgets extends StatelessWidget {
//   final String storeID;

//   const LiveStreamsWidgets(this.storeID);

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Column(
//       children: [
//         Container(
//           color: Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Current & Upcoming streams',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       _showDialogBox(context);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
//                       decoration: new BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.0),
//                         border: Border.all(
//                           color: MyColors().toShipButtonColor,
//                           width: 1.5,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Current Live Streams ',
//                             style: TextStyle(color: Colors.grey, fontSize: 9),
//                           ),
//                           // PopupMenuButton(
//                           //     offset: Offset.zero,
//                           //     padding : EdgeInsets.all(1.0),
//                           //   onSelected: (selectedValue) {
//                           //     print(selectedValue);
//                           //     // setState(() {
//                           //     //   if (selectedValue == FilterOptions.Favorites) {
//                           //     //     _showOnlyFavorites = true;
//                           //     //   } else {
//                           //     //     _showOnlyFavorites = false;
//                           //     //   }
//                           //     // });
//                           //   },
//                           //   icon: Icon(
//                           //     Icons.keyboard_arrow_down_sharp,
//                           //   ),
//                           //   itemBuilder: (_) => [
//                           //     PopupMenuItem(
//                           //       child: Text('Only Favorites'),
//                           //       value: "Current",
//                           //     ),
//                           //     PopupMenuItem(
//                           //       child: Text('Only Favorites'),
//                           //       value: "Upcoming",
//                           //     ),
//                           //     PopupMenuItem(
//                           //       child: Text('All'),
//                           //       value: 'All',
//                           //     ),
//                           //   ],
//                           // ),
//                           Icon(Icons.keyboard_arrow_down_sharp)
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Consumer<FollowedStoreProvider>(
//                 builder: (context, storesObject, child) {
//                   // print('widget value-'+bookMarkedSession.key);

//                   var storeDetails = storesObject.stores
//                       .firstWhere((item) => item.storeID == storeID);
//                   List<LiveStreamDataModel> currentLiveStreamList =
//                       storeDetails.liveStreamDataModel;
//                   return currentLiveStreamList.isEmpty
//                       ? Column(
//                           children: <Widget>[
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(child: Text('0 result')),
//                           ],
//                         )
//                       : Container(
//                           height: 250,
//                           padding: EdgeInsets.only(top: 10),
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (ctx, index) {
//                               return Container(
//                                 child: Column(
//                                   children: [
//                                     Stack(children: [
//                                       Container(
//                                         width: 150.0,
//                                         height: 200.0,
//                                         margin: EdgeInsets.symmetric(
//                                           horizontal: 6,
//                                         ),
//                                         decoration: new BoxDecoration(
//                                           color: Colors.blue,
//                                           shape: BoxShape.rectangle,
//                                           image: new DecorationImage(
//                                             image: AssetImage(
//                                                 currentLiveStreamList[index]
//                                                     .image),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                           top: 0,
//                                           left: 5,
//                                           child: Container(
//                                             padding: EdgeInsets.only(top: 5),
//                                             width: 150.0,
//                                             decoration: BoxDecoration(
//                                               gradient: new LinearGradient(
//                                                 colors: [
//                                                   Colors.black54,
//                                                   Colors.transparent,
//                                                 ],
//                                                 begin: Alignment.topCenter,
//                                                 end: Alignment.bottomCenter,
//                                               ),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Container(
//                                                       margin:
//                                                           EdgeInsets.symmetric(
//                                                               horizontal: 2),
//                                                       padding:
//                                                           EdgeInsets.all(5),
//                                                       decoration:
//                                                           new BoxDecoration(
//                                                         border: Border.all(
//                                                           color: Colors.red,
//                                                           width: 2.5,
//                                                         ),
//                                                         color: Colors.white,
//                                                         shape: BoxShape.circle,
//                                                         // image: new DecorationImage(
//                                                         //   fit: BoxFit.contain,
//                                                         //   image: AssetImage("assets/images/wlogo.png"),
//                                                         // ),
//                                                       ),
//                                                       child: Image.network(
//                                                         storeDetails.storeLogo,
//                                                         width: 20,
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       storeDetails.storeName,
//                                                       style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 12),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Container()
//                                               ],
//                                             ),
//                                           )),
//                                       Positioned(
//                                         bottom: 5,
//                                         left: 10,
//                                         child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 4, horizontal: 6),
//                                           decoration: new BoxDecoration(
//                                             color: Colors.black38,
//                                             borderRadius:
//                                                 BorderRadius.circular(50.0),
//                                             // border: Border.all(
//                                             //   color: MyColors().toShipButtonColor,
//                                             //   width: 1.5,
//                                             // ),
//                                           ),
//                                           child: Text(
//                                             currentLiveStreamList[index]
//                                                 .category,
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       ),
//                                     ]),
//                                     Container(
//                                       // color: Colors.blue,
//                                       padding: EdgeInsets.only(
//                                           left: 5, bottom: 4, top: 4),
//                                       width: 150.0,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 currentLiveStreamList[index]
//                                                     .sessionTitle,
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 12),
//                                               ),
//                                               Text(
//                                                 'Upcoming·15 Sep 2·13:00',
//                                                 style: TextStyle(fontSize: 8),
//                                               ),
//                                             ],
//                                           ),
//                                           GestureDetector(
//                                             onTap: () =>
//                                                 _streamOptions(context),
//                                             child: Icon(
//                                               Icons.more_vert,
//                                               size: 18,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             itemCount: currentLiveStreamList.length,
//                           ),
//                         );
//                 },
//               ),
//               // Container(
//               //   height: 250,
//               //   padding: EdgeInsets.only(top: 10),
//               //   child: ListView.builder(
//               //     scrollDirection: Axis.horizontal,
//               //     itemBuilder: (ctx, index) {
//               //       return Container(
//               //         child: Column(
//               //           children: [
//               //             Stack(children: [
//               //               Container(
//               //                 width: 150.0,
//               //                 height: 200.0,
//               //                 margin: EdgeInsets.symmetric(
//               //                   horizontal: 6,
//               //                 ),
//               //                 decoration: new BoxDecoration(
//               //                   color: Colors.blue,
//               //                   shape: BoxShape.rectangle,
//               //                   image: new DecorationImage(
//               //                     image: AssetImage(
//               //                         _currentLiveStreamList[index].image),
//               //                     fit: BoxFit.cover,
//               //                   ),
//               //                 ),
//               //               ),
//               //               Positioned(
//               //                   top: 0,
//               //                   left: 5,
//               //                   child: Container(
//               //                     padding: EdgeInsets.only(top: 5),
//               //                     width: 150.0,
//               //                     decoration: BoxDecoration(
//               //                       gradient: new LinearGradient(
//               //                         colors: [
//               //                           Colors.black54,
//               //                           Colors.transparent,
//               //                         ],
//               //                         begin: Alignment.topCenter,
//               //                         end: Alignment.bottomCenter,
//               //                       ),
//               //                     ),
//               //                     child: Row(
//               //                       mainAxisAlignment:
//               //                           MainAxisAlignment.spaceBetween,
//               //                       children: [
//               //                         Row(
//               //                           children: [
//               //                             Container(
//               //                               // margin: EdgeInsets.only(right: 10),
//               //                               padding: EdgeInsets.all(7),
//               //                               decoration: new BoxDecoration(
//               //                                 border: Border.all(
//               //                                   color: Colors.red,
//               //                                   width: 2.5,
//               //                                 ),
//               //                                 color: Colors.white,
//               //                                 shape: BoxShape.circle,
//               //                                 // image: new DecorationImage(
//               //                                 //   fit: BoxFit.contain,
//               //                                 //   image: AssetImage("assets/images/wlogo.png"),
//               //                                 // ),
//               //                               ),
//               //                               child: Image.asset(
//               //                                 'assets/images/wlogo.png',
//               //                                 width: 20,
//               //                               ),
//               //                             ),
//               //                             Text(
//               //                               "Shop Name",
//               //                               style:
//               //                                   TextStyle(color: Colors.white),
//               //                             ),
//               //                           ],
//               //                         ),
//               //                         Container()
//               //                       ],
//               //                     ),
//               //                   )),
//               //               Positioned(
//               //                 bottom: 5,
//               //                 left: 10,
//               //                 child: Container(
//               //                   padding: EdgeInsets.symmetric(
//               //                       vertical: 4, horizontal: 6),
//               //                   decoration: new BoxDecoration(
//               //                     color: Colors.black38,
//               //                     borderRadius: BorderRadius.circular(50.0),
//               //                     // border: Border.all(
//               //                     //   color: MyColors().toShipButtonColor,
//               //                     //   width: 1.5,
//               //                     // ),
//               //                   ),
//               //                   child: Text(
//               //                     'Women’s Apparel',
//               //                     style: TextStyle(
//               //                         color: Colors.white, fontSize: 12),
//               //                   ),
//               //                 ),
//               //               ),
//               //             ]),
//               //             Container(
//               //               // color: Colors.blue,
//               //               padding:
//               //                   EdgeInsets.only(left: 5, bottom: 4, top: 4),
//               //               width: 150.0,
//               //               child: Row(
//               //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //                 children: [
//               //                   Column(
//               //                     crossAxisAlignment: CrossAxisAlignment.start,
//               //                     children: [
//               //                       Text(
//               //                         'Session Title',
//               //                         style: TextStyle(
//               //                             fontWeight: FontWeight.bold,
//               //                             fontSize: 12),
//               //                       ),
//               //                       Text(
//               //                         'Upcoming·15 Sep 2·13:00',
//               //                         style: TextStyle(fontSize: 8),
//               //                       ),
//               //                     ],
//               //                   ),
//               //                   GestureDetector(
//               //                     onTap: () => _streamOptions(context),
//               //                     child: Icon(
//               //                       Icons.more_vert,
//               //                       size: 18,
//               //                     ),
//               //                   ),
//               //                 ],
//               //               ),
//               //             ),
//               //           ],
//               //         ),
//               //       );
//               //     },
//               //     itemCount: _currentLiveStreamList.length,
//               //   ),
//               // )
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Container(
//           color: Colors.white,
//           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Past streams',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Consumer<FollowedStoreProvider>(
//                 builder: (context, storesObject, child) {
//                   // print('widget value-'+bookMarkedSession.key);

//                   var storeDetails = storesObject.stores
//                       .firstWhere((item) => item.storeID == storeID);
//                   List<LiveStreamDataModel> pastLiveStreamList =
//                       storeDetails.liveStreamDataModel;
//                   return pastLiveStreamList.isEmpty
//                       ? Column(
//                           children: <Widget>[
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(child: Text('0 result')),
//                           ],
//                         )
//                       : Container(
//                           height: 250,
//                           padding: EdgeInsets.only(top: 10),
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (ctx, index) {
//                               return Container(
//                                 child: Column(
//                                   children: [
//                                     Stack(children: [
//                                       Container(
//                                         width: 150.0,
//                                         height: 200.0,
//                                         margin: EdgeInsets.symmetric(
//                                           horizontal: 6,
//                                         ),
//                                         decoration: new BoxDecoration(
//                                           color: Colors.blue,
//                                           shape: BoxShape.rectangle,
//                                           image: new DecorationImage(
//                                             image: AssetImage(
//                                                 pastLiveStreamList[index]
//                                                     .image),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                           top: 0,
//                                           left: 5,
//                                           child: Container(
//                                             width: 150.0,
//                                             padding: EdgeInsets.only(top: 5),
//                                             decoration: BoxDecoration(
//                                               gradient: new LinearGradient(
//                                                 colors: [
//                                                   Colors.black54,
//                                                   Colors.transparent,
//                                                 ],
//                                                 begin: Alignment.topCenter,
//                                                 end: Alignment.bottomCenter,
//                                               ),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Container(
//                                                       // margin: EdgeInsets.only(right: 10),
//                                                       padding:
//                                                           EdgeInsets.all(7),
//                                                       decoration:
//                                                           new BoxDecoration(
//                                                         border: Border.all(
//                                                           color: Colors.red,
//                                                           width: 2.5,
//                                                         ),
//                                                         color: Colors.white,
//                                                         shape: BoxShape.circle,
//                                                         // image: new DecorationImage(
//                                                         //   fit: BoxFit.contain,
//                                                         //   image: AssetImage("assets/images/wlogo.png"),
//                                                         // ),
//                                                       ),
//                                                       child: Image.asset(
//                                                         'assets/images/wlogo.png',
//                                                         width: 20,
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       storeDetails.storeName,
//                                                       style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 12),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Container()
//                                               ],
//                                             ),
//                                           )),
//                                       Positioned(
//                                         bottom: 5,
//                                         left: 10,
//                                         child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 4, horizontal: 6),
//                                           decoration: new BoxDecoration(
//                                             color: Colors.black38,
//                                             borderRadius:
//                                                 BorderRadius.circular(50.0),
//                                             // border: Border.all(
//                                             //   color: MyColors().toShipButtonColor,
//                                             //   width: 1.5,
//                                             // ),
//                                           ),
//                                           child: Text(
//                                             'Women’s Apparel',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       ),
//                                     ]),
//                                     Container(
//                                       // color: Colors.blue,
//                                       padding: EdgeInsets.only(
//                                           left: 5, bottom: 4, top: 4),
//                                       width: 150.0,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Session Title',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 12),
//                                               ),
//                                               Text(
//                                                 'Upcoming·15 Sep 2·13:00',
//                                                 style: TextStyle(fontSize: 8),
//                                               ),
//                                             ],
//                                           ),
//                                           GestureDetector(
//                                             onTap: () =>
//                                                 _streamOptions(context),
//                                             child: Icon(
//                                               Icons.more_vert,
//                                               size: 18,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             itemCount: pastLiveStreamList.length,
//                           ),
//                         );
//                 },
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   _streamOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return GestureDetector(
//           onTap: () {},
//           child: Container(
//             height: 220,
//             padding: EdgeInsets.all(10),
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.end,
//               // mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Container(
//                   // margin: EdgeInsets.symmetric(),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.close),
//                         // tooltip: 'Increase volume by 10',
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     print('bookmarked');
//                     Provider.of<BookMarkedSessionProvider>(context,
//                             listen: false)
//                         .addNewSession(BookmarkedSessionModel(
//                             'Earphone, Earbuds, Speakers, etc',
//                             "AGL105",
//                             'Sweet Spot',
//                             'https://quocent.com/assets/favicon/apple-touch-icon.png',
//                             'assets/images/img2.jpg',
//                             '5th September 2020',
//                             '11:00',
//                             BMCategoryModel('1', "Electronics")));
//                   },
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.bookmark_border,
//                         color: MyColors().iconColor,
//                         size: 28,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text('Add to bookmark')
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.favorite_border_outlined,
//                       color: MyColors().iconColor,
//                       size: 28,
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text('Like')
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Share.share('text');
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 3),
//                           child: Image.asset(
//                             'assets/images/share-icon.png',
//                             width: 25,
//                           ),
//                         ),

//                         // FaIcon(
//                         //   FontAwesomeIcons.shareSquare,
//                         //   size: 20,
//                         // ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text('Share')
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           behavior: HitTestBehavior.opaque,
//         );
//       },
//     );
//   }

//   Future<void> _showDialogBox(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           // title: Text('AlertDialog Title'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Current Live Streaming'),
//                 ),
//                 Divider(),
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Upcoming Live Streaming'),
//                 ),
//                 Divider(),
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Show All'),
//                 ),
//               ],
//             ),
//           ),
//           // actions: <Widget>[
//           //   TextButton(
//           //     child: Text('Approve'),
//           //     onPressed: () {},
//           //   ),
//           // ],
//         );
//       },
//     );
//   }
// }
