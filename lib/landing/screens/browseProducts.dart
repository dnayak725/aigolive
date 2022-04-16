// import 'package:aigolive/config/colors.dart';
// import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
// import 'package:aigolive/landing/Helpers/SearchBar.dart';
// import 'package:aigolive/landing/Helpers/StreamHelper.dart';
// import 'package:aigolive/landing/models/streamModel.dart';
// import 'package:aigolive/landing/providers/browseByCategoryProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BrowseProductScreen extends StatefulWidget {
//   final String browseCategory;
//   BrowseProductScreen(this.browseCategory);
//   @override
//   _BrowseProductScreenState createState() => _BrowseProductScreenState();
// }

// class _BrowseProductScreenState extends State<BrowseProductScreen>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;
//   MyColors mycolor = new MyColors();
//   List<String> categotyFilters = ["Best Match", "Recent", "Views"];
//   int activeFilterIndex = 0;

//   void filterProducts(filterValue, filterIndex) {
//     setState(() {
//       activeFilterIndex = filterIndex;
//     });
//   }

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: AppBarPopButton(),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: SearchBar(
//           isbackNav: false,
//           subCatSearch: widget.browseCategory,
//         ),
//       ),
//       body: Consumer<BrowseByCategoryProvider>(
//         builder: (context, browseByCategoryProvider, child) {
//           List<StreamModel> streamList = browseByCategoryProvider.streamList;

//           return Container(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       elevation: 5,
//                       child: TabBar(
//                         indicator: UnderlineTabIndicator(
//                           borderSide: BorderSide(
//                             width: 2.0,
//                             color: mycolor.iconColor,
//                           ),
//                           insets: EdgeInsets.symmetric(horizontal: 16.0),
//                         ),
//                         controller: _tabController,
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                           color: mycolor.whiteBgTitle,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         unselectedLabelColor: mycolor.whiteBgTitle,
//                         labelColor: mycolor.whiteBgTitle,
//                         tabs: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Tab(text: 'LIVE'),
//                               Icon(Icons.wifi),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Tab(text: 'REPLAY'),
//                               Icon(Icons.play_arrow),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Container(
//                     // color: Colors.amber,
//                     child: Row(
//                       children: List.generate(
//                         categotyFilters.length,
//                             (i) => Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               filterProducts(categotyFilters[i], i);
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   top: BorderSide(
//                                     color: Colors.grey[400],
//                                   ),
//                                   right: i == 1
//                                       ? BorderSide(
//                                     color: Colors.grey[400],
//                                   )
//                                       : BorderSide.none,
//                                   left: i == 1
//                                       ? BorderSide(
//                                     color: Colors.grey[400],
//                                   )
//                                       : BorderSide.none,
//                                   bottom: BorderSide(
//                                     color: i == activeFilterIndex
//                                         ? mycolor.iconColor
//                                         : Colors.grey[400],
//                                     width: i == activeFilterIndex ? 2.0 : 1.0,
//                                   ),
//                                 ),
//                               ),
//                               padding: EdgeInsets.all(12),
//                               child: Text(
//                                 '${categotyFilters[i]}',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     child: GridView.count(
//                       physics: ScrollPhysics(),
//                       shrinkWrap: true,
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.77,
//                       crossAxisSpacing: 20,
//                       controller: new ScrollController(keepScrollOffset: false),
//                       children: streamList
//                           .map((e) => StreamHelper(
//                         streamImage: e.img,
//                         streamTitle: e.title,
//                         totalWatched: e.watching,
//                         timePassed: e.timePassed,
//                       ))
//                           .toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
