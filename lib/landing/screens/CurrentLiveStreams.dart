import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/Helpers/StreamSliderHelp.dart';
import 'package:aigolive/landing/providers/onAirStreamsProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CurrentLiveStreams extends StatefulWidget {
  @override
  _CurrentLiveStreamsState createState() => _CurrentLiveStreamsState();
}

class _CurrentLiveStreamsState extends State<CurrentLiveStreams> {
  MyColors mycolor = new MyColors();
  @override
  void initState() {
    Provider.of<OnAirStreamsProvider>(context, listen: false).fetchData();
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
          ifNoSearchStringToDisplay: "New This Week",
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
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: StreamSliderHelp(
            widgetDirection: Axis.vertical,
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
          ),
          // child: Consumer<ComingUpNextProvider>(
          //   builder: (context, comingUpNextProvider, child) {
          //     List<CoomingUpNext> comingUpNxtList =
          //         comingUpNextProvider.comingUpNextList;
          //     return GridView.builder(
          //       physics: ScrollPhysics(),
          //       shrinkWrap: true,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         childAspectRatio: 0.65,
          //         crossAxisSpacing: 10,
          //       ),
          //       controller: new ScrollController(keepScrollOffset: false),
          //       itemCount: comingUpNxtList.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Container(
          //           child: Column(
          //             children: [
          //               Stack(children: [
          //                 Container(
          //                   width:
          //                       (MediaQuery.of(context).size.width - 30) * .42,
          //                   height:
          //                       (MediaQuery.of(context).size.width - 30) * .42,
          //                   margin: EdgeInsets.symmetric(
          //                     horizontal: 6,
          //                   ),
          //                   decoration: new BoxDecoration(
          //                     color: Colors.blue,
          //                     shape: BoxShape.rectangle,
          //                     image: new DecorationImage(
          //                       image: NetworkImage(
          //                           comingUpNxtList[index].sessionThumbnail),
          //                       fit: BoxFit.cover,
          //                     ),
          //                   ),
          //                 ),
          //                 Positioned(
          //                   top: 5,
          //                   right: 10,
          //                   child: Container(
          //                     padding: EdgeInsets.symmetric(
          //                         vertical: 4, horizontal: 6),
          //                     decoration: new BoxDecoration(
          //                       color: Colors.black38,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(4)),
          //                       // border: Border.all(
          //                       //   color: MyColors().toShipButtonColor,
          //                       //   width: 1.5,
          //                       // ),
          //                     ),
          //                     child: Text(
          //                       "UPCOMING",
          //                       style: TextStyle(
          //                           color: Colors.white, fontSize: 10),
          //                     ),
          //                   ),
          //                 ),
          //               ]),

          //               //title and session start time
          //               Container(
          //                 // color: Colors.blue,
          //                 padding: EdgeInsets.only(left: 0, bottom: 4, top: 4),
          //                 width: (MediaQuery.of(context).size.width - 30) * .42,
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Expanded(
          //                           child: Container(
          //                             // width:
          //                             //     ((MediaQuery.of(context).size.width -
          //                             //                 30) *
          //                             //             .4) -
          //                             //         20,
          //                             child: Text(
          //                               comingUpNxtList[index].sessionName,
          //                               overflow: TextOverflow.ellipsis,
          //                               maxLines: 2,
          //                               style: TextStyle(
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 12),
          //                             ),
          //                           ),
          //                         ),
          //                         GestureDetector(
          //                           onTap: () => Share.share("Text here"),
          //                           child: Icon(
          //                             Icons.more_vert,
          //                             size: 18,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     Container(
          //                       child: Text(
          //                         "shp name shop name shop name",
          //                         overflow: TextOverflow.ellipsis,
          //                         maxLines: 1,
          //                         style: TextStyle(
          //                             // fontWeight: FontWeight.bold,
          //                             fontSize: 10),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       height: 2,
          //                     ),
          //                     Container(
          //                       child: index == 0
          //                           ? Text(
          //                               "Tomorrow, 2:30pm",
          //                               style: TextStyle(fontSize: 10),
          //                             )
          //                           : Text(
          //                               "Today, 2:30pm",
          //                               style: TextStyle(fontSize: 10),
          //                             ),
          //                     ),
          //                     SizedBox(
          //                       height: 2,
          //                     ),
          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         GestureDetector(
          //                           onTap: () {
          //                             // Navigator.push(
          //                             //   context,
          //                             //   MaterialPageRoute(
          //                             //       builder: (context) => OrderCancelScreen(orderDetails)),
          //                             // );
          //                           },
          //                           child: Container(
          //                             padding: EdgeInsets.symmetric(
          //                                 vertical: 2, horizontal: 6),
          //                             decoration: new BoxDecoration(
          //                               borderRadius: BorderRadius.all(
          //                                   Radius.circular(4)),
          //                               color:
          //                                   MyColors().orderCancelButtonColor,
          //                             ),
          //                             child: Text(
          //                               'Remind Me',
          //                               style: TextStyle(
          //                                   color: Colors.white, fontSize: 10),
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
        ),
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
