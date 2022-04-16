import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/marketPlace/models/MKProductModel.dart';
import 'package:aigolive/landing/marketPlace/providers/weeklyDealsProovider.dart';
import 'package:aigolive/landing/marketPlace/widgets/weeklyDealsWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class WeeklyDealsScreen extends StatefulWidget {
  @override
  _WeeklyDealsScreenState createState() => _WeeklyDealsScreenState();
}

class _WeeklyDealsScreenState extends State<WeeklyDealsScreen> {
  MyColors mycolor = new MyColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: SearchBar(
          isbackNav: false,
          isSearchField: false,
          isSearchIcon: false,
          ifNoSearchStringToDisplay: 'Weekly Deals',
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: WeeklyDealsWidgets(
                  widgetDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
