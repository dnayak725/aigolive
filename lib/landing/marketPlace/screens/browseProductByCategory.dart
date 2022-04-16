import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/marketPlace/Helpers/BrowsByCategoryHelper.dart';
import 'package:aigolive/landing/marketPlace/models/searchProductListBySearchKeyModel.dart';
import 'package:aigolive/landing/marketPlace/providers/marketBrowseByCategoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketBrowseByCategory extends StatefulWidget {
  final String catId;
  final String browseCategotyName;
  MarketBrowseByCategory({
    this.catId,
    this.browseCategotyName,
  });
  @override
  _MarketBrowseByCategoryState createState() => _MarketBrowseByCategoryState();
}

class _MarketBrowseByCategoryState extends State<MarketBrowseByCategory>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  MyColors mycolor = new MyColors();
  List<String> categotyFilters = ["Popular", "Recent", "Price"];

  @override
  void initState() {
    print(widget.catId);
    Provider.of<MarketBrowseByCategoryProvider>(context, listen: false)
        .searchProductList = [];
    if (widget.catId != null) {
      Provider.of<MarketBrowseByCategoryProvider>(context, listen: false)
          .fetchDataById(int.parse(widget.catId));
    } else {
      Provider.of<MarketBrowseByCategoryProvider>(context, listen: false)
          .fetchDataByName(widget.browseCategotyName);
    }
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // leading: AppBarPopButton(),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [mycolor.blueDark, mycolor.blueLight],
            ),
          ),
        ),
        elevation: 0,
        title: SearchBar(
          isSearchIcon: false,
          isSuffixSearch: true,
          isbackNav: true,
          subCatSearch: widget.browseCategotyName,
          searchToPage: (String searchText) async {
            await Provider.of<MarketBrowseByCategoryProvider>(context,
                    listen: false)
                .reset();
            Provider.of<MarketBrowseByCategoryProvider>(context, listen: false)
                .fetchDataByName(searchText);
          },
        ),
      ),
      body: Consumer<MarketBrowseByCategoryProvider>(
        builder: (context, browseByCategoryProvider, child) {
          List<SearchProductListBySearchKeyModel> searchSessionList =
              browseByCategoryProvider.searchProductList;
          int sessioncarGridLength = searchSessionList.length;
          int activeFilterIndex = browseByCategoryProvider.activeFilterIndex;
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: List.generate(
                        categotyFilters.length,
                        (i) => Expanded(
                          child: GestureDetector(
                            onTap: () {
                              browseByCategoryProvider.filterProducts(
                                  categotyFilters[i], i);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey[400],
                                  ),
                                  bottom: BorderSide(
                                    color: i == activeFilterIndex
                                        ? mycolor.iconColor
                                        : Colors.grey[400],
                                    width: i == activeFilterIndex ? 2.0 : 1.0,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${categotyFilters[i]}',
                                    textAlign: TextAlign.center,
                                  ),
                                  categotyFilters[i] == "Price"
                                      ? Icon(
                                          browseByCategoryProvider.priceOrder ==
                                                  "ASC"
                                              ? Icons.keyboard_arrow_down
                                              : Icons.keyboard_arrow_up,
                                          size: 15,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: sessioncarGridLength,
                        itemBuilder: (context, index) {
                          return BrowsByCategoryHelper(
                            searchResult: searchSessionList[index],
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
