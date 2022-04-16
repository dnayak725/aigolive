import 'package:aigolive/landing/marketPlace/providers/marketBrowseByCategoryProvider.dart';
import 'package:aigolive/landing/marketPlace/screens/browseProductByCategory.dart';
import 'package:aigolive/landing/marketPlace/screens/marketPlaceAllCategories.dart';
import 'package:aigolive/landing/models/productCategoriesModel.dart';
import 'package:aigolive/landing/providers/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketPlaceCategoryGrid extends StatefulWidget {
  @override
  _MarketPlaceCategoryGridState createState() =>
      _MarketPlaceCategoryGridState();
}

class _MarketPlaceCategoryGridState extends State<MarketPlaceCategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
      List<Category> streamList = categoryProvider.categoryList;
      int gridLength = streamList.length;
      return streamList.isNotEmpty
          ? ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 230,
                maxHeight: 260,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridLength > 8 ? 2 : 4,
                  childAspectRatio: gridLength > 8 ? 1.4 : 1.3,
                ),
                itemCount: gridLength,
                physics: ScrollPhysics(),
                scrollDirection:
                    gridLength > 8 ? Axis.horizontal : Axis.vertical,
                shrinkWrap: true,
                controller: new ScrollController(keepScrollOffset: false),
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      categoryProvider.setActiveCategory(index);
                      // categoryProvider.showSubcategoryList(index);
                      if (categoryProvider.subCatList.isEmpty) {
                        Provider.of<MarketBrowseByCategoryProvider>(context,
                                listen: false)
                            .reset();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarketBrowseByCategory(
                              catId: streamList[index].id,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarketPlaceAllCategories(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          Container(
                            // margin: EdgeInsets.only(bottom: 10),
                            height: 70,
                            width: 70,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                  streamList[index].image,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            streamList[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              heightFactor: 2.5,
              child: Text('No Results Found'),
            );
    });
  }
}
