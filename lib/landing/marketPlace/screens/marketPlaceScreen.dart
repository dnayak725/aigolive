import 'dart:async';
import 'dart:convert';
import 'package:aigolive/landing/marketPlace/models/MKProductModel.dart';
import 'package:aigolive/landing/marketPlace/providers/NothingAboveProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/RecommendedProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/marketBrowseByCategoryProvider.dart';
import 'package:aigolive/landing/marketPlace/providers/weeklyDealsProovider.dart';
import 'package:aigolive/landing/marketPlace/screens/recomendedScreen.dart';
import 'package:aigolive/landing/marketPlace/widgets/RecomendedWidgets.dart';
import 'package:aigolive/landing/marketPlace/widgets/nothingAboveWidgets.dart';
import 'package:aigolive/landing/providers/categoryProvider.dart';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/marketPlace/Helpers/MarketPlaceCategoryGrid.dart';
import 'package:aigolive/landing/marketPlace/models/MarketSliderModel.dart';
import 'package:aigolive/landing/marketPlace/providers/marketSliderProvider.dart';
import 'package:aigolive/landing/marketPlace/screens/browseProductByCategory.dart';
import 'package:aigolive/landing/marketPlace/screens/marketPlaceAllCategories.dart';
import 'package:aigolive/landing/marketPlace/screens/weeklyDealsScreen.dart';
import 'package:aigolive/landing/marketPlace/screens/nothingAboveProductsScreen.dart';
import 'package:aigolive/landing/Helpers/ChannelSliderHelp.dart';
import 'package:aigolive/landing/Helpers/HeadLinkText.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/components/Enums.dart';
import 'package:aigolive/landing/models/mainSlider.dart';
import 'package:aigolive/landing/marketPlace/widgets/weeklyDealsWidgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'weeklyDealsScreen.dart';

class MarketPlaceScreen extends StatefulWidget {
  MarketPlaceScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MarketPlaceScreenState createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  MyColors mycolor = new MyColors();

  fetchIsLogin() async {
    // print("LTPL: getting value from  sp");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('status') &&
        sharedPreferences.getString("status") == "success") {
      var id = sharedPreferences.getString("user_id");
      var status = sharedPreferences.getString("status");
      // print("LTPL: user id = " + sharedPreferences.getString("user_id"));
      // Provider.of<UserLoginStatusProvider>(context, listen: false)
      //     .setLoginStatus(status);
      // Provider.of<UserLoginStatusProvider>(context, listen: false)
      //     .setUserID(id);
      // Provider.of<UserProfileProvider>(context, listen: false).fetchData(id);
    }
    // return true;
  }

  fetchData() async {
    await Provider.of<MarketSliderImageProvider>(context, listen: false)
        .fetchData();
    await fetchWeeklyDealsData();
    await Provider.of<CategoryProvider>(context, listen: false).fetchData();
    await Provider.of<NothingAboveProvider>(context, listen: false).fetchData();
    await Provider.of<RecommendedProductListProvider>(context, listen: false)
        .fetchData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchIsLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            Provider.of<MarketBrowseByCategoryProvider>(context, listen: false)
                .reset();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MarketBrowseByCategory(
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
                  child: Consumer<MarketSliderImageProvider>(
                      builder: (context, marketSliderImageProvider, child) {
                    List<MarketSliderImage> sliderList =
                        marketSliderImageProvider.sliderImageList;
                    return sliderList.length > 0
                        ? CarouselSlider.builder(
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
                //upcoming live streams secton
                _weeklyDealsWidget(),
                _categories(),
                _nothingAboveWidget(),
                //channels you may like section
                // _channelsYouMayLikeSection(),
                _recommendedWidget(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  _categories() {
    return Container(
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
                  builder: (context) => MarketPlaceAllCategories(),
                ),
              );
            },
            pageContext: context,
          ),
          MarketPlaceCategoryGrid(),
        ],
      ),
    );
  }

  _weeklyDealsWidget() {
    return Container(
      padding: EdgeInsets.only(top: 15),
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
            heading: 'Weekly Deals',
            linkText: 'See All',
            secKey: NavigateToPage.upcomingStreams,
            headColor: mycolor.whiteBgTitle,
            linkColor: mycolor.seeallLink,
            pageNavigation: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeeklyDealsScreen()),
              );
            },
            pageContext: context,
          ),
          // StreamSliderHelp(
          //   sliderName: 'live_slide',
          //   height: 240,
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: ((MediaQuery.of(context).size.width - 30) * .42) + 90,
            child: WeeklyDealsWidgets(
              widgetDirection: Axis.horizontal,
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10,
            ),
          ),
        ],
      ),
    );
  }

  _nothingAboveWidget() {
    return Container(
      padding: EdgeInsets.only(top: 20),
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
            heading: 'Nothing Above \$5',
            linkText: 'See All',
            secKey: NavigateToPage.upcomingStreams,
            headColor: mycolor.whiteBgTitle,
            linkColor: mycolor.seeallLink,
            pageNavigation: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NothingAboveProductsScreen()),
              );
            },
            pageContext: context,
          ),
          // StreamSliderHelp(
          //   sliderName: 'live_slide',
          //   height: 240,
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: ((MediaQuery.of(context).size.width - 30) * .42) + 90,
            child: NothingAboveWidgets(
              widgetDirection: Axis.horizontal,
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10,
            ),
          ),
        ],
      ),
    );
  }

  _recommendedWidget() {
    return Container(
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
                MaterialPageRoute(builder: (context) => RecomendedScreen()),
              );
            },
            pageContext: context,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: ((MediaQuery.of(context).size.width - 30) * .42) + 90,
            child: RecommendedPLWidgets(
              widgetDirection: Axis.horizontal,
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        ],
      ),
    );
  }

  _channelsYouMayLikeSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [MyColors().blueLight, MyColors().blueDark],
        ),
      ),
      child: Column(
        children: [
          HeadLinkText(
            heading: 'Channels you may like',
            secKey: NavigateToPage.currentLive,
            headColor: Colors.white,
          ),
          ChannelSliderHelp(),
        ],
      ),
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
        });
  }

  //call apis
  fetchWeeklyDealsData() async {
    final response = await http.get(
      ApiLinks().weeklyDealsProductListApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    print("LTPL: called" + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          var data = results['data'];
          List<MKProductModel> temp = [];
          data.forEach((item) {
            temp.add(MKProductModel(
                item['product_id'].toString(),
                item['product_name'].toString(),
                item['product_image'].toString(),
                item['product_selling_price'].toString(),
                item['product_price'].toString(),
                item['discountpercent'].toString(),
                item['quantity'].toString(),
                item['seller_id'].toString(),
                "",
                item['totalsold'].toString()));
          });
          // streamList = temp;
          Provider.of<WeeklyDealsProvider>(context, listen: false)
              .setWeeklyDealsProductList(temp);
          Provider.of<WeeklyDealsProvider>(context, listen: false)
              .listFetchingStatus = "fetched";
        }
        print("LTPL: GetOnAirStream api data fetched");
        break;

      default:
        print("LTPL: GetOnAirStream api error");
        break;
    }
  }
}
