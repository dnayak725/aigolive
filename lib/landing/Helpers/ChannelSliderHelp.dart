import 'dart:convert';
import 'package:aigolive/landing/models/channelStreamSliderModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelSliderHelp extends StatelessWidget {
  Future<String> loadSlider() async {
    return await rootBundle.loadString('assets/testdata/channelStream.json');
  }

  Future<ChannelList> getSlider() async {
    String jsonString = await loadSlider();
    ChannelList channelSlider =
        new ChannelList.fromJson(json.decode(jsonString));
    return channelSlider;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: FutureBuilder(
        future: getSlider(),
        builder: (ctxt, snapshot) {
          if (snapshot.hasData) {
            var items = snapshot.data.channelList;
            return CarouselSlider.builder(
              itemCount: items.length,
              options: CarouselOptions(
                viewportFraction: 1.0,
                autoPlay: false,
                disableCenter: true,
              ),
              itemBuilder: (ctx, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      items.length,
                      (i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          overflow: Overflow.visible,
                          children: [
                            Container(
                              width: 70,
                              padding: EdgeInsets.all(20),
                              decoration: new BoxDecoration(
                                border: items[i].status == "live"
                                    ? Border.all(
                                        color: Colors.red,
                                        width: 2.5,
                                      )
                                    : Border.all(
                                        color: Colors.white,
                                        width: 2.5,
                                      ),
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  // fit: BoxFit.contain,
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(items[i].logo),
                                ),
                              ),
                            ),
                            items[i].status == "live"
                                ? Positioned(
                                    bottom: -2,
                                    width: 40,
                                    child: Container(
                                      padding: EdgeInsets.all(2.5),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Live',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ).toList(),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
