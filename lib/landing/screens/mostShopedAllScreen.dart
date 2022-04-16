import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/Helpers/MostShopedHelper.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/providers/mostShopedProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MostShopedAll extends StatefulWidget {
  @override
  _MostShopedAllState createState() => _MostShopedAllState();
}

class _MostShopedAllState extends State<MostShopedAll> {
  MyColors mycolor = new MyColors();
  @override
  void initState() {
    Provider.of<MostShopedProvider>(context, listen: false).fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: SearchBar(
          isbackNav: false,
          isSearchField: false,
          isSearchIcon: false,
          ifNoSearchStringToDisplay: "Most Shopped",
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: MostShopedHelper(
            widgetDirection: Axis.vertical,
            crossAxisCount: 2,
            childAspectRatio: 0.80,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
