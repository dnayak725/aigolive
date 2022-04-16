import 'dart:convert';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/Helpers/HeadLinkText.dart';
import 'package:aigolive/landing/Helpers/SelectSlider.dart';
import 'package:aigolive/landing/Helpers/StreamItem.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpcomingStreams extends StatefulWidget {
  @override
  _UpcomingStreamsState createState() => _UpcomingStreamsState();
}

class _UpcomingStreamsState extends State<UpcomingStreams> {
  MyColors mycolor = new MyColors();
  Future<String> loadStream() async {
    return await rootBundle.loadString("assets/testdata/upcomingStream.json");
  }

  Future<StreamList> getStream() async {
    String jsonString = await loadStream();
    StreamList streamList = StreamList.fromJson(json.decode(jsonString));
    return streamList;
  }

  void showForm(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Align(
                child: Text('Like'),
                alignment: Alignment(-1.2, 0),
              ),
            ),
            Divider(height: 0),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.shareSquare,
                size: 20,
              ),
              title: Align(
                child: Text('Share'),
                alignment: Alignment(-1.2, 0),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming streams'),
        centerTitle: true,
        leading: AppBarPopButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [MyColors().blueDark, MyColors().blueLight],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: mycolor.lightGrey,
                child: Column(
                  children: [
                    HeadLinkText(
                      heading: 'Category',
                      headingAlign: MainAxisAlignment.center,
                      headColor: mycolor.whiteBgTitle,
                    ),
                    SelectSlider()
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: FutureBuilder(
                  future: getStream(),
                  builder: (ctxt, snapshot) {
                    if (snapshot.hasData) {
                      var item = snapshot.data.streamList;
                      return GridView.count(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 10,
                        controller:
                            new ScrollController(keepScrollOffset: false),
                        children: List.generate(
                          item.length,
                          (index) => StreamItem(
                            streamList: item,
                            index: index,
                            action: showForm,
                          ),
                        ).toList(),
                      );
                    } else {
                      return Center(
                        child: Container(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNav(),
    );
  }
}
