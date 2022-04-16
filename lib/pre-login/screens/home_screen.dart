import 'package:aigolive/account-setting/orders/screens/cancellation_screen.dart';
import 'package:aigolive/account-setting/orders/screens/my_purchases_screen.dart';
import 'package:aigolive/account-setting/screens/account_screen.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:aigolive/stores/screens/followed_stores_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount _currentUser;
  String _contactText = 'hi';
  String _mode = 'checking';
  final FacebookLogin facebookLogin = FacebookLogin();

  int bottomNavIndex = 0;
  final navItems = const [
    {
      "name": "Home",
      "logo_inactive": "assets/images/home_inactive.png",
      "logo_active": "assets/images/home_active.png"
    },
    {
      "name": "Bookmark",
      "logo_inactive": "assets/images/bookmark_inactive.png",
      "logo_active": "assets/images/bookmark_active.png"
    },
    {
      "name": "Streaming",
      "logo_inactive": "assets/images/live_inactive.png",
      "logo_active": "assets/images/live_active.png"
    },
    {
      "name": "Order",
      "logo_inactive": "assets/images/order_inactive.png",
      "logo_active": "assets/images/order_inactive.png"
    },
    {
      "name": "Account",
      "logo_inactive": "assets/images/account_inactive.png",
      "logo_active": "assets/images/account_active.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    // var userData = Provider.of<LoginDetailsProvider>(context);
    checkLoginStatus();
    // _checkInternetConnectivity();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // if (sharedPreferences.getString("token") == null) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    //       (Route<dynamic> route) => false);
    // }
    // context
    //     .read<LoginDetailsProvider>()
    //     .setLoginMode(sharedPreferences.getString("mode").toString());
    // context
    //     .read<LoginDetailsProvider>()
    //     .setUserName(sharedPreferences.getString("name").toString());
    // context
    //     .read<LoginDetailsProvider>()
    //     .setPhotoUrl(sharedPreferences.getString("photoUrl").toString());
    // setState(() {
    //   _contactText = sharedPreferences.getString("name").toString() +
    //       ', you are logged in';
    //   _mode = sharedPreferences.getString("mode").toString();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AiGo Live", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.store_mall_directory_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FollowedStoresScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LiveStreamScreen(1)),
              // );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child:
            // sharedPreferences.getString("name") != null
            //     ? Column(
            //         children: <Widget>[
            //           // Image.network(sharedPreferences.getString("photoUrl").toString(), height: 50.0, width: 50.0,),
            //           Text(
            //             sharedPreferences.getString("name").toString(),
            //           ),
            //         ],
            //       )
            //     :
            Text(" , You are logged in using } Mode."),
      ),
      drawer: _getDrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        onTap: (navIndex) {
          setState(() {
            bottomNavIndex = navIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[900],
        items: navItems
            .map((nav) => BottomNavigationBarItem(
                  icon: Image.asset(
                    nav['logo_inactive'],
                    scale: 1,
                    width: 25,
                  ),
                  activeIcon: Image.asset(
                    nav['logo_active'],
                    scale: 1,
                    width: 25,
                  ),
                  title: Text(nav['name']),
                ))
            .toList(),
      ),
    );
  }

  _logout() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    if (_mode == 'GOOGLE') {
      try {
        _googleSignIn.signOut();
      } catch (err) {
        print(err);
      }
    }
    if (_mode == 'FACEBOOK') {
      try {
        //_googleSignIn.signOut();
        facebookLogin.logOut();
      } catch (err) {
        print(err);
      }
    }
    sharedPreferences.clear();
    sharedPreferences.commit();
  }

  Drawer _getDrawerWidget() {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://image.freepik.com/free-photo/shopping-online-home-concept-blue-background-copyspace_1205-6303.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Text("John Deo"),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                ListTile(
                  title: Text("Home"),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("My purchases"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyPurchasesScreen(0, false)),
                    );
                  },
                ),
                ListTile(
                  title: Text("Login"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                // ListTile(
                //   title: Text("Cancelled orders"),
                //   onTap: () {
                //     Navigator.pop(context);
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => CancellationScreen()),
                //     );
                //   },
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog('No internet', "You're not connected to a network");
    } else if (result == ConnectivityResult.mobile) {
      _showDialog('Internet access', "You're connected over mobile data");
    } else if (result == ConnectivityResult.wifi) {
      _showDialog('Internet access', "You're connected over wifi");
    }
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
}
