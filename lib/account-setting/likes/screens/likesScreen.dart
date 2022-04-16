import 'package:aigolive/account-setting/likes/widgets/likedProductsWidgets.dart';
import 'package:aigolive/account-setting/likes/widgets/likedSessionWidgets.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:flutter/material.dart';

class LikesScreen extends StatefulWidget {
  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Likes'),
        centerTitle: true,
        leading: AppBarPopButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [MyColors().blueDark, MyColors().blueLight],
            ),
          ),
        ),
      ),
      body: bottomNavIndex == 1
          ? LikedSessionWidgets()
          : (bottomNavIndex == 2 ? LikedProductWidgets() : Container()),
      bottomNavigationBar: _bottomNav(),
    );
  }

  //code for bottom nav bar
  int bottomNavIndex = 1;

  final navItems = const [
    {
      "name": "Cart",
      "logo_inactive": "assets/images/cart_inactive.png",
      "logo_active": "assets/images/cart_active.png"
    },
    {
      "name": "Liked Sessions",
      "logo_inactive": "assets/images/liked_session_inactive.png",
      "logo_active": "assets/images/liked_session_active.png"
    },
    {
      "name": "Liked Products",
      "logo_inactive": "assets/images/bag_inactive.png",
      "logo_active": "assets/images/bag_active.png"
    },
    {
      "name": "Notifications",
      "logo_inactive": "assets/images/notification_inactive.png",
      "logo_active": "assets/images/notification_active.png"
    },
  ];

  _bottomNav() {
    return BottomNavigationBar(
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: bottomNavIndex,
        onTap: (navIndex) {
          // setState(() {
          //   bottomNavIndex = navIndex;
          // });
          switch (navIndex) {
            case 0:
              // moveToPage(NavigateToPage.home, context);
              break;
            case 1:
              setState(() {
                bottomNavIndex = navIndex;
              });
              break;
            case 2:
              setState(() {
                bottomNavIndex = navIndex;
              });
              break;
            case 3:
              // moveToPage(NavigateToPage.order, context);
              break;
          }
          print(bottomNavIndex);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.grey[600],
        items: navItems
            .map((nav) => BottomNavigationBarItem(
                  icon: Image.asset(
                    nav['logo_inactive'],
                    scale: 1,
                    width: 20, //reduced icon size 25 to 20
                  ),
                  activeIcon: Image.asset(
                    nav['logo_active'],
                    scale: 1,
                    width: 20, //reduced icon size 25 to 20
                  ),
                  label: nav['name'],
                ))
            .toList());
  }
  //end code for bottom nav bar
}
