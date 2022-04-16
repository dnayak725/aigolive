import 'dart:convert';
import 'package:aigolive/landing/models/productCategoriesModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectSlider extends StatefulWidget {
  @override
  _SelectSliderState createState() => _SelectSliderState();
}

class _SelectSliderState extends State<SelectSlider> {
  int activeId = 0;

  // Future<String> loadCategory() async {
  //   return await rootBundle
  //       .loadString('assets/testdata/productCategories.json');
  // }

  // Future<CategoryList> getCategory() async {
  //   String jsonString = await loadCategory();
  //   CategoryList categoryList =
  //       new CategoryList.fromJson(json.decode(jsonString));
  //   return categoryList;
  // }

  void activeItem(int id) {
    setState(() {
      activeId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      // child: FutureBuilder(
      //   future: getCategory(),
      //   builder: (ctxt, snapshot) {
      //     if (snapshot.hasData) {
      //       var item = snapshot.data.categoryList;
      //       return CarouselSlider.builder(
      //         itemCount: item.length,
      //         options: CarouselOptions(
      //           viewportFraction: 1.0,
      //           autoPlay: false,
      //           disableCenter: true,
      //         ),
      //         itemBuilder: (ctx, index) {
      //           return SingleChildScrollView(
      //             scrollDirection: Axis.horizontal,
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: List.generate(
      //                 item.length,
      //                 (i) => GestureDetector(
      //                   onTap: () {
      //                     activeItem(item[i].id);
      //                   },
      //                   child: Container(
      //                     width: MediaQuery.of(context).size.width / 4.39,
      //                     child: Column(
      //                       children: [
      //                         Container(
      //                           height: 60,
      //                           decoration: new BoxDecoration(
      //                             border: Border.all(
      //                               color: activeId == item[i].id
      //                                   ? Colors.amber[900]
      //                                   : Colors.grey,
      //                               width: 1.5,
      //                             ),
      //                             color: Colors.white,
      //                             shape: BoxShape.circle,
      //                             image: new DecorationImage(
      //                               fit: BoxFit.contain,
      //                               image: AssetImage(
      //                                 item[i].image,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                         Text(
      //                           item[i].name,
      //                           textAlign: TextAlign.center,
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     } else {
      //       return Center(
      //         child: Container(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
