import 'dart:async';

import 'package:aigolive/account-setting/bookmark/providers/bookmarkedSessionProvider.dart';
import 'package:aigolive/account-setting/bookmark/screens/bookmarkedSessionScreen.dart';
import 'package:aigolive/account-setting/likes/screens/likesScreen.dart';
import 'package:aigolive/account-setting/orders/screens/my_purchases_screen.dart';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/account-setting/screens/recentlyViewedScreen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:aigolive/stores/screens/followed_stores_screen.dart';
import 'package:flutter/material.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account_setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      var userId = sharedPreferences.getString("user_id");
      Provider.of<UserProfileProvider>(context, listen: false)
          .fetchData(userId);
      Provider.of<BookMarkedSessionProvider>(context, listen: false)
          .fetchData(userId);
      Provider.of<FollowedStoreProvider>(context, listen: false)
          .fetchData(userId);
      // print("LTPL: profile data fetched");
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    }
  }

  Timer _timer;
  @override
  void initState() {
    super.initState();
    syncData();
    _timer = Timer.periodic(Duration(seconds: 60), (Timer t) => syncData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: new Container(
          child: Column(
            children: [
              SizedBox(
                height: 0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [MyColors().blueDark, MyColors().blueLight],
                  ),
                ),
                // color: Colors.red,
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      margin: EdgeInsets.only(top: 8.0, bottom: 20),
                      child: Consumer<UserProfileProvider>(
                        builder: (context, userProfileProvider, child) {
                          return Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: new BoxDecoration(
                                  // color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  image: new DecorationImage(
                                    image: NetworkImage(
                                        userProfileProvider.photoUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                userProfileProvider.fullName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      margin: EdgeInsets.only(top: 8.0, bottom: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // print('hu');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FollowedStoresScreen()),
                              );
                            },
                            child: Column(
                              children: [
                                Text(
                                  Provider.of<FollowedStoreProvider>(context)
                                      .stores
                                      .length
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Followed',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Stores',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BookmarkedSessionScreen(
                                          isNeedPop: true,
                                        )),
                              );
                            },
                            child: Column(
                              children: [
                                Text(
                                  Provider.of<BookMarkedSessionProvider>(
                                          context)
                                      .bookmarkedSessionList
                                      .length
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Bookmarked',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Sessions',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(top: 8.0, bottom: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Orders',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: _navigateToOrderScreen,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'View All Orders',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyPurchasesScreen(1, false)),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                width: 30,
                                child: Image.asset(
                                  'assets/images/to_ship.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                'To Ship',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyPurchasesScreen(2, false)),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                width: 30,
                                child: Image.asset(
                                  'assets/images/to_receive.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                'To Receive',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyPurchasesScreen(3, false)),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                width: 30,
                                child: Image.asset(
                                  'assets/images/cancel.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                'Delivered',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyPurchasesScreen(4, false)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: 30,
                                  child: Image.asset(
                                    'assets/images/delivered.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  'Cancellations',
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 10,
                // color: Colors.grey,
                color: MyColors().lightGrey,
              ),
              Container(
                child: Column(
                  children: [
                    // Container(
                    //   child: FlatButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (BuildContext context) =>
                    //                 RecentlyViewedScreen()),
                    //       );
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text('Recently Viewed'),
                    //         Icon(
                    //           Icons.chevron_right_sharp,
                    //           color: MyColors().iconColor,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Divider(
                    //   height: 1,
                    // ),
                    Container(
                      child: FlatButton(
                        onPressed: _navigateToAccountSettingScreen,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Account Settings'),
                            Icon(
                              Icons.chevron_right_sharp,
                              color: MyColors().iconColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 10,
                // color: Colors.grey,
                color: MyColors().lightGrey,
              ),
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Support',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          // _launchURL("");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Help Centre'),
                            Icon(
                              Icons.chevron_right_sharp,
                              color: MyColors().iconColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          _launchURL(
                              "https://agl.bluecube.com.sg/Buyers/SellonAigo");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sell on AiGo'),
                            Icon(
                              Icons.chevron_right_sharp,
                              color: MyColors().iconColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          _launchURL(
                              "https://agl.bluecube.com.sg/Buyers/PrivacyPolicy");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('AiGo Policies'),
                            Icon(
                              Icons.chevron_right_sharp,
                              color: MyColors().iconColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          _launchURL(
                              "https://agl.bluecube.com.sg/Buyers/CommunityPolicies");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Community Rules'),
                            Icon(
                              Icons.chevron_right_sharp,
                              color: MyColors().iconColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                // color: Colors.grey,
                color: MyColors().lightGrey,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(2),
    );
  }

  _navigateToOrderScreen() {
    //signup screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyPurchasesScreen(0, false)),
    );
  }

  _navigateToAccountSettingScreen() {
    //signup screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountSettingScreen()),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showAlertDialog("Alert!", "Could not launch $url", "Ok", context);
    }
  }

  _showAlertDialog(String alertText, String msg, String buttonText, context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertText),
          content: Text(msg),
          actions: [
            FlatButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
