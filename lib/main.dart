import 'package:aigolive/account-setting/bookmark/providers/bookmarkedSessionProvider.dart';
import 'package:aigolive/account-setting/likes/providers/likesProvider.dart';
import 'package:aigolive/account-setting/orders/providers/purchases.dart';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/cart/providers/CartProductsProvider.dart';
import 'package:aigolive/chat/providers/chatProvider.dart';
import 'package:aigolive/chat/providers/notificationProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/NothingAboveProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/RecommendedProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/marketBrowseByCategoryProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/marketSliderProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/weeklyDealsProovider.dart';
import 'package:aigolive/landing/providers/bannerTagProvider.dart';
import 'package:aigolive/landing/providers/bannerTagStreamProvider.dart';
import 'package:aigolive/landing/providers/browseByCategoryProvider.dart';
import 'package:aigolive/landing/providers/categoryProvider.dart';
import 'package:aigolive/landing/providers/comingUpNextProvider.dart';
import 'package:aigolive/landing/providers/homeSliderImageProvider.dart';
import 'package:aigolive/landing/providers/mostShopedProvider.dart';
import 'package:aigolive/landing/providers/mostWatchedProvider.dart';
import 'package:aigolive/landing/providers/onAirStreamsProvider.dart';
import 'package:aigolive/landing/providers/recommendedProvider.dart';
import 'package:aigolive/landing/providers/userLoginStatusProvider.dart';
import 'package:aigolive/landing/screens/Home.dart';
import 'package:aigolive/live-steaming/providers/ControlStreamScreenProvider.dart';
import 'package:aigolive/live-steaming/providers/LiveProductListProvider.dart';
import 'package:aigolive/live-steaming/providers/SessionDetailsProductsProvider.dart';
import 'package:aigolive/live-steaming/providers/userMessageProvider.dart';
import 'package:aigolive/live-steaming/providers/video_player_provider.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:aigolive/stores/providers/frontStoreSessionProvider.dart';
import 'package:aigolive/stores/providers/productDetailsProvider.dart';
import 'package:aigolive/stores/providers/storeProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Purchases(),
        ),
        ChangeNotifierProvider.value(
          value: VideoPlayerProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LiveProductListProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ControlStreamScreenPovider(),
        ),
        ChangeNotifierProvider.value(
          value: UserMessageProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BookMarkedSessionProvider(),
        ),
        ChangeNotifierProvider.value(
          value: FollowedStoreProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserLoginStatusProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserProfileProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OnAirStreamsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ComingUpNextProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LikesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CategoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BrowseByCategoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: WeeklyDealsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: NotificationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: StoreProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ChatProvider(),
        ),
        ChangeNotifierProvider.value(
          value: StoreProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BannerTagStreamProvider(),
        ),
        ChangeNotifierProvider.value(
          value: HomeSliderImageProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BannerTagProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MostShopedProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MostWatchedProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MarketSliderImageProvider(),
        ),
        ChangeNotifierProvider.value(
          value: RecommendedProvider(),
        ),
        ChangeNotifierProvider.value(
          value: NothingAboveProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProductDetailsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MarketBrowseByCategoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SessionDetailsProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: FrontStoreSessionProvider(),
        ),
        ChangeNotifierProvider.value(
          value: RecommendedProductListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AiGo Live',
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "OpenSans",
        ),
        home: CallSplashScreen(),
      ),
    );
  }
}

class CallSplashScreen extends StatefulWidget {
  @override
  _CallSplashScreenState createState() => new _CallSplashScreenState();
}

class _CallSplashScreenState extends State<CallSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      routeName: "/",
      seconds: 3,
      navigateAfterSeconds: MyHomePage(),
      image: new Image.asset('assets/images/Logo-white.png'),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 80.0,
      gradientBackground: LinearGradient(
        colors: [Color.fromRGBO(0, 0, 153, 1), Color.fromRGBO(0, 153, 255, 1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      loaderColor: Color.fromRGBO(0, 0, 153, 0),
    );
  }
}
