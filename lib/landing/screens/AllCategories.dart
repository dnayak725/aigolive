import 'dart:convert';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/landing/models/productCategoriesModel.dart';
import 'package:aigolive/landing/providers/categoryProvider.dart';
import 'package:aigolive/landing/screens/browseByCategoryScreen.dart';
import 'package:aigolive/pre-login/components/app_bar_pop_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  MyColors mycolors = new MyColors();

  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Categories'),
        centerTitle: true,
        leading: AppBarPopButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [mycolors.blueDark, mycolors.blueLight],
            ),
          ),
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          List<Category> streamList = categoryProvider.categoryList;
          int catGridLength = streamList.length;
          int activeCat = categoryProvider.activeCategory;
          if (streamList.isNotEmpty) {
            if (activeCat == 0) {
              categoryProvider.showSubcategoryList(activeCat);
            }
          }

          List<SubCategory> subCategoryList = streamList[activeCat].subCatList;
          int subCatGridLength = subCategoryList.length;
          return streamList.isNotEmpty
              ? Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: (scSize.width / 3.8) + 70,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 15,
                          right: 15,
                          left: 15,
                        ),
                        color: Colors.grey[300],
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: catGridLength,
                            itemBuilder: (ctxt, index) {
                              return GestureDetector(
                                onTap: () {
                                  print(streamList[index].subCatList.length);
                                  categoryProvider.setActiveCategory(index);
                                  if (streamList[index].subCatList.isEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BrowseByCategory(
                                          catId: streamList[index].id,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  width: scSize.width / 3.8,
                                  child: catItems(
                                    activeCat,
                                    index,
                                    streamList[index].image,
                                    streamList[index].name,
                                    scSize,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          controller: new ScrollController(
                            keepScrollOffset: false,
                          ),
                          itemCount: subCatGridLength,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BrowseByCategory(
                                      catId: subCategoryList[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                color: mycolors.whiteSection,
                                padding: EdgeInsets.all(8),
                                child: subcatItems(
                                  subCategoryList[index].image,
                                  subCategoryList[index].name,
                                  scSize,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  heightFactor: 2.5,
                  child: Text('No Results Found'),
                );
        },
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  Widget catItems(activeCat, activeIndex, image, name, scSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 70,
          width: 70,
          padding: EdgeInsets.all(1),
          decoration: new BoxDecoration(
            border: Border.all(
              color: activeCat == activeIndex ? Colors.amber : Colors.white,
              width: 1.5,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(
                image,
              ),
            ),
          ),
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget subcatItems(image, name, scSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          image,
          width: scSize.width / 4.5,
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }
}
