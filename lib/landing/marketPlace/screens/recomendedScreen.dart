import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/marketPlace/widgets/RecomendedWidgets.dart';
import 'package:flutter/material.dart';

class RecomendedScreen extends StatefulWidget {
  @override
  _RecomendedScreenState createState() => _RecomendedScreenState();
}

class _RecomendedScreenState extends State<RecomendedScreen> {
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
          ifNoSearchStringToDisplay: 'Recommended',
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
                child: RecommendedPLWidgets(
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
