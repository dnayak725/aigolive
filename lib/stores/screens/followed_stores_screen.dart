import 'dart:async';

import 'package:aigolive/config/colors.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:aigolive/stores/providers/followedStoresProvider.dart';
import 'package:aigolive/stores/screens/store_details_screen.dart';
import 'package:aigolive/stores/widgets/followed_stores_widgets.dart';
import 'package:flutter/material.dart';
import 'package:aigolive/pre-login/components/app_bar_pop_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowedStoresScreen extends StatefulWidget {
  @override
  _FollowedStoresScreenState createState() => _FollowedStoresScreenState();
}

class _FollowedStoresScreenState extends State<FollowedStoresScreen> {
  Timer _timer;
  syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      var userId = sharedPreferences.getString("user_id");
      Provider.of<FollowedStoreProvider>(context, listen: false)
          .fetchData(userId);
      // print("LTPL: profile data fetched");
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
      Provider.of<FollowedStoreProvider>(context, listen: false).reset();
      _timer?.cancel();
    }
  }

  @override
  void initState() {
    syncData();
    _timer = Timer.periodic(Duration(seconds: 15), (Timer t) => syncData());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().lightGrey,
      appBar: AppBar(
        title: Text('Followed Stores'),
        centerTitle: true,
        leading: AppBarPopButton(),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 85,
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(left: 15.0, right: 15, top: 30, bottom: 15),
              child: TextField(
                onChanged: (value) {
                  // print('input value - ' + value);
                  Provider.of<FollowedStoreProvider>(context, listen: false)
                      .setKey(value);
                },
                decoration: InputDecoration(
                  hintText: "Search Shop Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  prefixIcon: Icon(
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
            FollowedStoresWidgets(),
          ],
        ),
      ),
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
