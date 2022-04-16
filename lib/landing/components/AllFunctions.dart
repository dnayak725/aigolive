import 'package:aigolive/account-setting/bookmark/screens/bookmarkedSessionScreen.dart';
import 'package:aigolive/account-setting/orders/screens/my_purchases_screen.dart';
import 'package:aigolive/account-setting/screens/account_screen.dart';
import 'package:aigolive/landing/screens/AllCategories.dart';
import 'package:aigolive/landing/screens/CurrentLiveStreams.dart';
import 'package:aigolive/landing/screens/comingUpNextScreen.dart';
import 'package:aigolive/landing/screens/Home.dart';
import 'package:aigolive/landing/marketPlace/screens/marketPlaceScreen.dart';

import 'package:flutter/material.dart';

import 'Enums.dart';

// void showHideSearchBar() {
//   global.searchBar ? global.searchBar = false : global.searchBar = true;
// }

void moveToPage(NavigateToPage page, pageContext) {
  switch (page) {
    case NavigateToPage.home:
      Navigator.of(pageContext).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(),
        ),
        (Route<dynamic> route) => false,
      );
      break;
    case NavigateToPage.marketPlace:
      Navigator.of(pageContext).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => MarketPlaceScreen(),
        ),
        (Route<dynamic> route) => false,
      );
      break;
    case NavigateToPage.currentLive:
      Navigator.of(pageContext).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => CurrentLiveStreams(),
        ),
        (Route<dynamic> route) => false,
      );
      break;
    case NavigateToPage.upcomingStreams:
      Navigator.of(pageContext).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => UpcomingStreams(),
        ),
        (Route<dynamic> route) => false,
      );
      break;
    case NavigateToPage.order:
      Navigator.of(pageContext).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => MyPurchasesScreen(0, true)),
        (Route<dynamic> route) => false,
      );
      break;
    case NavigateToPage.account:
      Navigator.of(pageContext).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => AccountScreen(),
        ),
        (Route<dynamic> route) => false,
      );
      break;
    default:
  }
}
