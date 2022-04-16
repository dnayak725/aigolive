import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/HeadLinkText.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/components/Enums.dart';
import 'package:aigolive/pre-login/components/app_bar_pop_button.dart';
import 'package:aigolive/stores/models/product_model.dart';
import 'package:aigolive/stores/models/storeModel.dart';
import 'package:aigolive/stores/models/storeSessionModel.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:aigolive/stores/providers/frontStoreSessionProvider.dart';
import 'package:aigolive/stores/screens/allStoreProductsScreen.dart';
import 'package:aigolive/stores/screens/allStoreSessionsScreen.dart';
import 'package:aigolive/stores/widgets/storeProductWidget.dart';
import 'package:aigolive/stores/widgets/storeSessionWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreDetailsScreen extends StatefulWidget {
  final String storeId;
  final String storeName;

  const StoreDetailsScreen({
    this.storeId,
    this.storeName,
  });

  @override
  _StoreDetailsScreenState createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen>
    with SingleTickerProviderStateMixin {
  MyColors mycolor = new MyColors();

  var userId;
  getStoreAndStoreDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString("user_id");
    await Provider.of<FrontStoreSessionProvider>(context, listen: false)
        .fetchData(widget.storeId);
    await Provider.of<FollowedStoreProvider>(context, listen: false)
        .fetchData(userId);
  }

  @override
  void initState() {
    super.initState();
    getStoreAndStoreDetails();
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
        title: SearchBar(
          isbackNav: false,
          isSearchIcon: false,
          isSearchField: false,
          ifNoSearchStringToDisplay: widget.storeName,
          iconColor: Colors.white,
        ),
        centerTitle: true,
        leading: AppBarPopButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [mycolor.blueDark, mycolor.blueLight],
            ),
          ),
        ),
      ),
      body: Consumer<FrontStoreSessionProvider>(
          builder: (context, storeSessionProvider, child) {
        StoreSession storeSessionResult = storeSessionProvider.storeSessionData;
        List<StorefrontSessionList> sessionList =
            storeSessionResult.storefrontSessionList;
        List<ProductModel> productList =
            storeSessionResult.storefrontProductList;
        int fetchStatus = storeSessionProvider.fetchStatus;
        switch (fetchStatus) {
          case 0:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case 200:
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        children: [
                          storeSessionResult.coverimage != ""
                              ? Image.network(
                                  storeSessionResult.coverimage,
                                  fit: BoxFit.cover,
                                )
                              : SizedBox(),
                          storeSessionResult.coverimage != ""
                              ? SizedBox(height: 10)
                              : SizedBox(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors().iconColor,
                                  width: 2.5,
                                ),
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(storeSessionResult.logo),
                                ),
                              ),
                            ),
                            title: Text(
                              storeSessionResult.shopName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              storeSessionResult.numberOfFollowers,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Consumer<FollowedStoreProvider>(
                                builder: (context, storesObject, child) {
                              List<StoreModel> checkStores =
                                  storesObject.stores;
                              int storeIndex = checkStores.indexWhere(
                                  (element) =>
                                      element.storeID == widget.storeId);
                              return RaisedButton(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 2,
                                ),
                                child: Text(
                                  storeIndex >= 0 ? 'Following' : 'Follow',
                                  style: TextStyle(fontSize: 12),
                                ),
                                textColor: storeIndex >= 0
                                    ? Colors.white
                                    : Colors.black,
                                color: storeIndex >= 0
                                    ? MyColors().iconColor
                                    : Colors.grey[600],
                                onPressed: () async {
                                  if (storeIndex >= 0) {
                                    await Provider.of<FollowedStoreProvider>(
                                            context,
                                            listen: false)
                                        .unfollowStore(
                                            checkStores[storeIndex].storeID,
                                            checkStores[storeIndex].customerID,
                                            false);
                                  } else {
                                    await Provider.of<FollowedStoreProvider>(
                                            context,
                                            listen: false)
                                        .unfollowStore(storeSessionResult.id,
                                            userId, true);
                                  }
                                },
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Image.network(
                                      storeSessionResult
                                          .featureseSsion.sessionThumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.grey[300],
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        NetworkImage(storeSessionResult.logo),
                                  ),
                                ),
                                // child: Center(
                                //   child: Text(
                                //     'L',
                                //     style: TextStyle(
                                //       fontSize: 20,
                                //     ),
                                //   ),
                                // ),
                              ),
                              title: Text(
                                storeSessionResult
                                    .featureseSsion.featuredSessionname,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${storeSessionResult.featureseSsion.watched} watched",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () => Share.share(
                                    storeSessionResult.featureseSsion.pageLink),
                                child: Icon(
                                  Icons.more_vert,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 3),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          HeadLinkText(
                            heading: 'Sessions',
                            linkText: 'See All',
                            secKey: NavigateToPage.upcomingStreams,
                            headColor: mycolor.whiteBgTitle,
                            linkColor: mycolor.seeallLink,
                            pageNavigation: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllStoreSession()),
                              );
                            },
                            pageContext: context,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: GridView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: sessionList.length >= 4
                                  ? 4
                                  : sessionList.length,
                              itemBuilder: (context, index) {
                                return StoreSessionWidget(
                                  storeDetails: storeSessionResult,
                                  storeSessionData: sessionList[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 3),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          HeadLinkText(
                            heading: 'Products',
                            linkText: 'See All',
                            secKey: NavigateToPage.upcomingStreams,
                            headColor: mycolor.whiteBgTitle,
                            linkColor: mycolor.seeallLink,
                            pageNavigation: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllStoreProducts()),
                              );
                            },
                            pageContext: context,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: GridView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.80,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: productList.length >= 4
                                  ? 4
                                  : productList.length,
                              itemBuilder: (context, index) {
                                return StoreProductWidget(
                                  storeDetails: storeSessionResult,
                                  productDetails: productList[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
            break;
          default:
            return Center(
              child: Text("Server error."),
            );
        }
      }),
    );
  }
}
