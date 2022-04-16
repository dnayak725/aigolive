import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/Helpers/RecommendedHelper.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aigolive/landing/providers/recommendedProvider.dart';

class RecommendedAll extends StatefulWidget {
  @override
  _RecommendedAllState createState() => _RecommendedAllState();
}

class _RecommendedAllState extends State<RecommendedAll> {
  MyColors mycolor = new MyColors();
 @override
  void initState() {
   Provider.of<RecommendedProvider>(context, listen: false).fetchData();
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
          ifNoSearchStringToDisplay: "Recommended",
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
          child: RecommendedHelper(
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
