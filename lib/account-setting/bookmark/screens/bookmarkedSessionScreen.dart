import 'dart:async';

import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/account-setting/bookmark/widgets/BookmarkedSessionWidgets.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:aigolive/account-setting/bookmark/providers/bookmarkedSessionProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkedSessionScreen extends StatefulWidget {
  final bool isNeedPop;

  const BookmarkedSessionScreen({Key key, this.isNeedPop}) : super(key: key);

  @override
  _BookmarkedSessionScreenState createState() =>
      _BookmarkedSessionScreenState();
}

class _BookmarkedSessionScreenState extends State<BookmarkedSessionScreen> {
  final TextEditingController _searchController = new TextEditingController();

  Timer _timer;
  syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      var userId = sharedPreferences.getString("user_id");
      Provider.of<BookMarkedSessionProvider>(context, listen: false)
          .fetchData(userId);
      // print("LTPL: profile data fetched");
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
      Provider.of<BookMarkedSessionProvider>(context, listen: false).reset();
      _timer?.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    syncData();
    _timer = Timer.periodic(Duration(seconds: 15), (Timer t) => syncData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: MyColors().lightGrey,
      appBar: AppBar(
        title: Text('Bookmarked sessions'),
        centerTitle: true,
        leading: widget.isNeedPop ? AccountBarPopButton() : Container(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [MyColors().blueDark, MyColors().blueLight],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 68,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value) {
                  Provider.of<BookMarkedSessionProvider>(context, listen: false)
                      .setKey(value);
                },
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Shop Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 10,
                    right: 0,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.blue[600],
                    size: 22,
                  ),
                  border: _searchBorder(),
                  focusedBorder: _searchBorder(),
                  enabledBorder: _searchBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BookmarkedSessionWidgets(),
            // Slidable(
            //   actionPane: SlidableDrawerActionPane(),
            //   actionExtentRatio: 0.25,
            //   child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            //       margin: EdgeInsets.only(bottom: 10),
            //       color: Colors.white,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: (MediaQuery.of(context).size.width - 30) * 0.3,
            //             child: Container(
            //               height: 120,
            //               width: 80,
            //               margin: EdgeInsets.only(
            //                 right: 10,
            //               ),
            //               padding: EdgeInsets.all(20),
            //               decoration: new BoxDecoration(
            //                 // border: Border.all(
            //                 //   color: Colors.red,
            //                 //   width: 2.5,
            //                 // ),
            //                 color: Colors.white,
            //                 // shape: BoxShape.circle,
            //                 image: new DecorationImage(
            //                   fit: BoxFit.contain,
            //                   image: AssetImage("assets/images/img2.jpg"),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: (MediaQuery.of(context).size.width - 30) * 0.7,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Container(
            //                   padding: EdgeInsets.only(left: 7),
            //                   width: (MediaQuery.of(context).size.width - 30) *
            //                       0.7,
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Container(
            //                         width: ((MediaQuery.of(context).size.width -
            //                                     30) *
            //                                 0.7) -
            //                             50,
            //                         child: Text(
            //                             'All about music - Earphone, Earbuds, Speakers & Accessories'),
            //                       ),
            //                       GestureDetector(
            //                         onTap: () {
            //                           Share.share('text');
            //                         },
            //                         child: Container(
            //                           child: Icon(
            //                             Icons.share,
            //                             size: 16,
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 8,
            //                 ),
            //                 Row(
            //                   children: [
            //                     Container(
            //                       // margin: EdgeInsets.only(right: 10),
            //                       padding: EdgeInsets.all(7),
            //                       decoration: new BoxDecoration(
            //                         border: Border.all(
            //                           color: Colors.grey,
            //                           width: 1,
            //                         ),
            //                         // color: Colors.white,
            //                         shape: BoxShape.circle,
            //                         // image: new DecorationImage(
            //                         //   fit: BoxFit.contain,
            //                         //   image: AssetImage("assets/images/wlogo.png"),
            //                         // ),
            //                       ),
            //                       child: Image.asset(
            //                         'assets/images/wlogo.png',
            //                         width: 20,
            //                       ),
            //                     ),
            //                     Text(
            //                       "Shop Name",
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   height: 8,
            //                 ),
            //                 Container(
            //                   padding: EdgeInsets.only(left: 7),
            //                   child: Text('5th September 2020'),
            //                 ),
            //                 Container(
            //                   padding: EdgeInsets.only(left: 7),
            //                   child: Text('12:00'),
            //                 ),
            //                 Container(
            //                   padding: EdgeInsets.only(left: 7),
            //                   child: Text(
            //                     'Electronic',
            //                     style: TextStyle(color: Colors.grey),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           )
            //         ],
            //       )),
            //   // actions: <Widget>[
            //   //   IconSlideAction(
            //   //     caption: 'Archive',
            //   //     color: Colors.blue,
            //   //     icon: Icons.archive,
            //   //     onTap: () {},
            //   //   ),
            //   //   IconSlideAction(
            //   //     caption: 'Share',
            //   //     color: Colors.indigo,
            //   //     icon: Icons.share,
            //   //     onTap: (){},
            //   //   ),
            //   // ],
            //   secondaryActions: <Widget>[
            //     // IconSlideAction(
            //     //   caption: 'More',
            //     //   color: Colors.black45,
            //     //   icon: Icons.more_horiz,
            //     //   onTap: () =>{},
            //     // ),
            //     IconSlideAction(
            //       // caption: 'Delete',
            //       color: Colors.red,
            //       icon: Icons.delete,
            //       onTap: () => {},
            //     ),
            //   ],
            // ),
            // Slidable(
            //   actionPane: SlidableDrawerActionPane(),
            //   actionExtentRatio: 0.25,
            //   child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            //       margin: EdgeInsets.only(bottom: 10),
            //       color: Colors.white,
            //       child: Row(
            //         children: [
            //           Container(
            //             width: (MediaQuery.of(context).size.width - 30) * 0.3,
            //             child: Container(
            //               height: 120,
            //               width: 80,
            //               margin: EdgeInsets.only(
            //                 right: 10,
            //               ),
            //               padding: EdgeInsets.all(20),
            //               decoration: new BoxDecoration(
            //                 // border: Border.all(
            //                 //   color: Colors.red,
            //                 //   width: 2.5,
            //                 // ),
            //                 color: Colors.white,
            //                 // shape: BoxShape.circle,
            //                 image: new DecorationImage(
            //                   fit: BoxFit.contain,
            //                   image: AssetImage("assets/images/img2.jpg"),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: (MediaQuery.of(context).size.width - 30) * 0.7,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Container(
            //                   padding: EdgeInsets.only(left: 7),
            //                   width: (MediaQuery.of(context).size.width - 30) *
            //                       0.7,
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Container(
            //                         width: ((MediaQuery.of(context).size.width -
            //                                     30) *
            //                                 0.7) -
            //                             50,
            //                         child: Text(
            //                             'All about music - Earphone, Earbuds, Speakers & Accessories'),
            //                       ),
            //                       GestureDetector(
            //                         onTap: () {
            //                           Share.share('text');
            //                         },
            //                         child: Container(
            //                           child: Icon(
            //                             Icons.share,
            //                             size: 16,
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 8,
            //                 ),
            //                 Row(
            //                   children: [
            //                     Container(
            //                       // margin: EdgeInsets.only(right: 10),
            //                       padding: EdgeInsets.all(7),
            //                       decoration: new BoxDecoration(
            //                         border: Border.all(
            //                           color: Colors.grey,
            //                           width: 1,
            //                         ),
            //                         // color: Colors.white,
            //                         shape: BoxShape.circle,
            //                         // image: new DecorationImage(
            //                         //   fit: BoxFit.contain,
            //                         //   image: AssetImage("assets/images/wlogo.png"),
            //                         // ),
            //                       ),
            //                       child: Image.asset(
            //                         'assets/images/wlogo.png',
            //                         width: 20,
            //                       ),
            //                     ),
            //                     Text(
            //                       "Shop Name",
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   height: 8,
            //                 ),
            //                 Container(
            //                   padding: EdgeInsets.only(left: 7),
            //                   child: Text('5th September 2020'),
            //                 ),
            //                 Container(
            //                   padding: EdgeInsets.only(left: 7),
            //                   child: Text('12:00'),
            //                 ),
            //                 Container(
            //                   padding: EdgeInsets.only(left: 7),
            //                   child: Text(
            //                     'Electronic',
            //                     style: TextStyle(color: Colors.grey),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           )
            //         ],
            //       )),
            //   // actions: <Widget>[
            //   //   IconSlideAction(
            //   //     caption: 'Archive',
            //   //     color: Colors.blue,
            //   //     icon: Icons.archive,
            //   //     onTap: () {},
            //   //   ),
            //   //   IconSlideAction(
            //   //     caption: 'Share',
            //   //     color: Colors.indigo,
            //   //     icon: Icons.share,
            //   //     onTap: (){},
            //   //   ),
            //   // ],
            //   secondaryActions: <Widget>[
            //     // IconSlideAction(
            //     //   caption: 'More',
            //     //   color: Colors.black45,
            //     //   icon: Icons.more_horiz,
            //     //   onTap: () =>{},
            //     // ),
            //     IconSlideAction(
            //       // caption: 'Delete',
            //       color: Colors.red,
            //       icon: Icons.delete,
            //       onTap: () => {},
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  OutlineInputBorder _searchBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue[600],
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
    );
  }
}
