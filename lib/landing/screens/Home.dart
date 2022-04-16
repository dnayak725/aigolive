import 'dart:async';
import 'dart:convert';
import 'package:aigolive/account-setting/orders/providers/purchases.dart';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/cart/providers/CartProductsProvider.dart';
import 'package:aigolive/landing/Global.dart' as global;
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/Helpers/CategoryGrid.dart';
import 'package:aigolive/landing/Helpers/MostShopedHelper.dart';
import 'package:aigolive/landing/Helpers/ComingUpNextSliderHelper.dart';
import 'package:aigolive/landing/Helpers/MostWatchedHelper.dart';
import 'package:aigolive/landing/Helpers/RecommendedHelper.dart';
import 'package:aigolive/landing/models/bannerTagModel.dart';
import 'package:aigolive/landing/models/newThisWeekModel.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/landing/providers/bannerTagProvider.dart';
import 'package:aigolive/landing/providers/categoryProvider.dart';
import 'package:aigolive/landing/providers/comingUpNextProvider.dart';
import 'package:aigolive/landing/providers/mostShopedProvider.dart';
import 'package:aigolive/landing/providers/mostWatchedProvider.dart';
import 'package:aigolive/landing/providers/onAirStreamsProvider.dart';
import 'package:aigolive/landing/providers/homeSliderImageProvider.dart';
import 'package:aigolive/landing/providers/recommendedProvider.dart';
import 'package:aigolive/landing/providers/userLoginStatusProvider.dart';
import 'package:aigolive/landing/screens/bannerTagScreen.dart';
import 'package:aigolive/landing/screens/browseByCategoryScreen.dart';
import 'package:aigolive/landing/screens/comingUpNextScreen.dart';
import 'package:aigolive/landing/screens/CurrentLiveStreams.dart';
import 'package:aigolive/landing/screens/AllCategories.dart';
import 'package:aigolive/landing/Helpers/ChannelSliderHelp.dart';
import 'package:aigolive/landing/Helpers/HeadLinkText.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/Helpers/StreamSliderHelp.dart';
import 'package:aigolive/landing/components/Enums.dart';
import 'package:aigolive/landing/models/mainSlider.dart';
import 'package:aigolive/landing/screens/mostShopedAllScreen.dart';
import 'package:aigolive/landing/screens/mostWatchedAllScreen.dart';
import 'package:aigolive/landing/screens/recommendedAllScreen.dart';
import 'package:aigolive/pre-login/widgets/socialAccountDetails.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyColors mycolor = new MyColors();
  Future<String> loadMainSlider() async {
    return await rootBundle.loadString("assets/testdata/mainSlider.json");
  }

  fetchIsLogin() async {
    // print("LTPL: getting value from  sp");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('status') &&
        sharedPreferences.getString("status") == "success") {
      var id = sharedPreferences.getString("user_id");
      var status = sharedPreferences.getString("status");
      // print("LTPL: user id = " + sharedPreferences.getString("user_id"));
      await Provider.of<CartProductsProvider>(context, listen: false)
          .fetchData();
      await Provider.of<UserLoginStatusProvider>(context, listen: false)
          .setLoginStatus(status);
      await Provider.of<UserLoginStatusProvider>(context, listen: false)
          .setUserID(id);
      await Provider.of<UserProfileProvider>(context, listen: false)
          .fetchData(id);
      var email = sharedPreferences.getString('email');
      var dob = sharedPreferences.getString('dob');
      var phone = sharedPreferences.getString('phone');
      if (email == "" || dob == "" || phone == "") {
        _showProfileDetailsDialog("Profile", id, email, dob, phone);
      }
    }
    // return true;
  }

  _showProfileDetailsDialog(alertText, id, email, dob, phone) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertText),
          content: SocialAccountDetails(
            userId: id,
            email: email,
            dob: dob,
            phone: phone,
          ),
        );
      },
    );
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog('No internet', "You're not connected to a network");
    }
    // else if (result == ConnectivityResult.mobile) {
    //   _showDialog('Internet access', "You're connected over mobile data");
    // } else if (result == ConnectivityResult.wifi) {
    //   _showDialog('Internet access', "You're connected over wifi");
    // }
  }

  fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('user_id')) {
      await Provider.of<CartProductsProvider>(context, listen: false)
          .fetchData();
    }
    await Provider.of<HomeSliderImageProvider>(context, listen: false)
        .fetchData();
    Provider.of<OnAirStreamsProvider>(context, listen: false).fetchData();
    await Provider.of<ComingUpNextProvider>(context, listen: false).fetchData();
    await Provider.of<CategoryProvider>(context, listen: false).fetchData();
    await Provider.of<BannerTagProvider>(context, listen: false).fetchData();
    await Provider.of<MostShopedProvider>(context, listen: false).fetchData();
    await Provider.of<MostWatchedProvider>(context, listen: false).fetchData();
    await Provider.of<RecommendedProvider>(context, listen: false).fetchData();
  }

  Timer _timer;
  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
    fetchData();
    fetchIsLogin();
    global.btmNavIndx = 0;
    // _timer = Timer.periodic(
    //   Duration(seconds: 15),
    //   (Timer t) =>
    //       Provider.of<OnAirStreamsProvider>(context, listen: false).fetchData(),
    // );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [MyColors().blueDark, MyColors().blueLight],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        elevation: 0,
        title: SearchBar(
          isbackNav: false,
          iconColor: Colors.white,
          isSearchIcon: false,
          isSuffixSearch: true,
          searchToPage: (String searchText) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BrowseByCategory(
                  browseCategotyName: searchText,
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 15),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Consumer<HomeSliderImageProvider>(
                      builder: (context, homeSliderImageProvider, child) {
                    List<MainSliderImage> sliderList =
                        homeSliderImageProvider.sliderImageList;
                    return sliderList.length > 0
                        ? Container(
                            child: CarouselSlider.builder(
                              itemCount: sliderList.length,
                              options: CarouselOptions(
                                viewportFraction: 1.0,
                                autoPlay: true,
                                disableCenter: true,
                              ),
                              itemBuilder: (ctx, index) {
                                return Container(
                                  child: Image.network(
                                    sliderList[index].img,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            ),
                          )
                        : CarouselSlider.builder(
                            itemCount: sliderList.length,
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              autoPlay: true,
                              disableCenter: true,
                            ),
                            itemBuilder: (ctx, index) {
                              return Container(
                                child: Image.asset(
                                  "assets/images/loading-preview.gif",
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          );
                  }),
                ),
                Consumer<OnAirStreamsProvider>(
                    builder: (context, onAirStreamsProvider, child) {
                  List<NewThisWeek> streamList =
                      onAirStreamsProvider.newThisWeek;
                  return streamList.isNotEmpty
                      ? Container(
                          child: Column(
                            children: [
                              HeadLinkText(
                                heading: 'New This Week',
                                linkText: 'See All',
                                secKey: NavigateToPage.currentLive,
                                padding: 15,
                                headColor: mycolor.whiteBgTitle,
                                linkColor: mycolor.seeallLink,
                                pageNavigation: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CurrentLiveStreams(),
                                    ),
                                  );
                                },
                                pageContext: context,
                              ),
                              Container(
                                // color: Colors.amber,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                height:
                                    ((MediaQuery.of(context).size.width - 30) *
                                            .42) +
                                        90,
                                child: StreamSliderHelp(
                                  widgetDirection: Axis.horizontal,
                                  crossAxisCount: 1,
                                  childAspectRatio: 1.5,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 10,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox();
                }),
                //upcoming live streams secton
                Container(
                  child: Column(
                    children: [
                      HeadLinkText(
                        heading: 'Editor\'s Picks',
                        linkText: 'See All',
                        secKey: NavigateToPage.upcomingStreams,
                        headColor: mycolor.whiteBgTitle,
                        linkColor: mycolor.seeallLink,
                        pageNavigation: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpcomingStreams(),
                            ),
                          );
                        },
                        pageContext: context,
                      ),
                      Container(
                        // color: Colors.amber,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        height:
                            ((MediaQuery.of(context).size.width - 30) * .42) +
                                90,
                        child: ComingUpNextSliderHelper(
                          widgetDirection: Axis.horizontal,
                          crossAxisCount: 1,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: mycolor.yellowBg,
                  child: Column(
                    children: [
                      HeadLinkText(
                        heading: 'Categories',
                        linkText: 'See All',
                        secKey: NavigateToPage.categories,
                        headColor: mycolor.yellowBgTitle,
                        linkColor: mycolor.seeallLink,
                        pageNavigation: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllCategories(),
                            ),
                          );
                        },
                        pageContext: context,
                      ),
                      CategoryGrid(
                        fromPageName: "Home",
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Consumer<BannerTagProvider>(
                      builder: (context, bannerTagProvider, child) {
                    List<BannerTag> bannerTagList =
                        bannerTagProvider.bannerTagList;
                    int status = bannerTagProvider.status;
                    if (status == 0) {
                      return Container(
                        child: Image.asset(
                          "assets/images/loading-preview.gif",
                          fit: BoxFit.fill,
                        ),
                      );
                    } else {
                      return bannerTagList.length > 0
                          ? Wrap(
                              children: bannerTagList
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BannerTagScreen(
                                            categoryName: e.name,
                                            catId: e.id,
                                          ),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5.0),
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30) *
                                                0.5,
                                            child: ClipRRect(
                                              // borderRadius: BorderRadius.vertical(
                                              //   top: Radius.circular(50),
                                              //   bottom: Radius.circular(20),
                                              // ),
                                              child: Image.network(
                                                e.img,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 25,
                                            left: 10,
                                            child: Text(
                                              e.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : Center(
                              heightFactor: 2.5,
                              child: Text('No Results Found'),
                            );
                    }
                  }),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: Image.asset(
                //           'assets/images/buynow_card_sm01.png',
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Expanded(
                //         child: Image.asset(
                //           'assets/images/buynow_card_sm02.png',
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      HeadLinkText(
                        heading: 'Most Watched',
                        linkText: 'See All',
                        secKey: NavigateToPage.upcomingStreams,
                        headColor: mycolor.whiteBgTitle,
                        linkColor: mycolor.seeallLink,
                        pageNavigation: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MostWatchedAll(),
                            ),
                          );
                        },
                        pageContext: context,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        height:
                            ((MediaQuery.of(context).size.width - 30) * .42) +
                                95,
                        child: MostWatchedHelper(
                          widgetDirection: Axis.horizontal,
                          crossAxisCount: 1,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.centerLeft,
                  //     end: Alignment.centerRight,
                  //     colors: [MyColors().blueDark, MyColors().blueLight],
                  //   ),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadLinkText(
                        heading: 'Most Shopped',
                        linkText: 'See All',
                        secKey: NavigateToPage.upcomingStreams,
                        headColor: mycolor.whiteBgTitle,
                        linkColor: mycolor.seeallLink,
                        pageNavigation: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MostShopedAll()),
                          );
                        },
                        pageContext: context,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        height:
                            ((MediaQuery.of(context).size.width - 30) * .42) +
                                95,
                        child: MostShopedHelper(
                          widgetDirection: Axis.horizontal,
                          crossAxisCount: 1,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                //channels you may like section
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 15),
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       colors: [MyColors().blueLight, MyColors().blueDark],
                //     ),
                //   ),
                //   child: Column(
                //     children: [
                //       HeadLinkText(
                //         heading: 'Channels you may like',
                //         secKey: NavigateToPage.currentLive,
                //         headColor: Colors.white,
                //       ),
                //       ChannelSliderHelp(),
                //     ],
                //   ),
                // ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadLinkText(
                        heading: 'Recommended',
                        linkText: 'See All',
                        secKey: NavigateToPage.upcomingStreams,
                        headColor: mycolor.whiteBgTitle,
                        linkColor: mycolor.seeallLink,
                        pageNavigation: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecommendedAll()),
                          );
                        },
                        pageContext: context,
                      ),
                      // StreamSliderHelp(
                      //   sliderName: 'live_slide',
                      //   height: 240,
                      // ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        height:
                            ((MediaQuery.of(context).size.width - 30) * .42) +
                                100,
                        child: RecommendedHelper(
                          widgetDirection: Axis.horizontal,
                          crossAxisCount: 1,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  _showDialog(title, text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
