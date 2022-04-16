import 'package:aigolive/landing/components/AllFunctions.dart';
import 'package:aigolive/landing/components/Enums.dart';
import 'package:flutter/material.dart';

import 'package:aigolive/landing/Global.dart' as global;

class BottomNav extends StatefulWidget {
  final int menuIndex;

  const BottomNav(this.menuIndex);
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int bottomNavIndex = global.btmNavIndx;
  final navItems = const [
    {
      "name": "Home",
      "logo_inactive": "assets/images/home_inactive.png",
      "logo_active": "assets/images/home_active.png"
    },
    {
      "name": "Marketplace",
      "logo_inactive": "assets/images/marketplace-inactive.png",
      "logo_active": "assets/images/marketplace-active.png"
    },
    {
      "name": "Streaming",
      "logo_inactive": "assets/images/live_inactive.png",
      "logo_active": "assets/images/live_active.png"
    },
    {
      "name": "Order",
      "logo_inactive": "assets/images/order_inactive.png",
      "logo_active": "assets/images/order.png"
    },
    {
      "name": "Account",
      "logo_inactive": "assets/images/account_inactive.png",
      "logo_active": "assets/images/account_active.png"
    },
  ];
  final navItems2 = const [
    {
      "name": "Home",
      "logo_inactive": "assets/images/home_inactive.png",
      "logo_active": "assets/images/home_active.png"
    },
    {
      "name": "Marketplace",
      "logo_inactive": "assets/images/marketplace-inactive.png",
      "logo_active": "assets/images/marketplace-active.png"
    },
    {
      "name": "Streaming",
      "logo_inactive": "assets/images/live_inactive.png",
      "logo_active": "assets/images/live_active.png"
    },
    {
      "name": "Cart",
      "logo_inactive": "assets/images/cart_inactive.png",
      "logo_active": "assets/images/cart_active.png"
    },
    {
      "name": "Message",
      "logo_inactive": "assets/images/account_inactive.png",
      "logo_active": "assets/images/account_active.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 10,
      unselectedFontSize: 10,
      currentIndex: bottomNavIndex,
      onTap: (navIndex) {
        setState(() {
          global.btmNavIndx = navIndex;
          bottomNavIndex = global.btmNavIndx;
        });
        switch (navIndex) {
          case 0:
            moveToPage(NavigateToPage.home, context);
            break;
          case 1:
            moveToPage(NavigateToPage.marketPlace, context);
            break;
          case 2:
            moveToPage(NavigateToPage.upcomingStreams, context);
            break;
          case 3:
            moveToPage(NavigateToPage.order, context);
            break;
          case 4:
            moveToPage(NavigateToPage.account, context);
            break;
        }
        print(bottomNavIndex);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.grey[600],
      items: widget.menuIndex == 1
          ? navItems
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
              .toList()
          : navItems2
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
              .toList(),
    );
  }
}
