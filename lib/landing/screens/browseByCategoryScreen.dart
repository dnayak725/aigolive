import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/landing/Helpers/BrowsByCategoryStreamHelper.dart';
import 'package:aigolive/landing/models/searchSessionListByCategory.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/landing/providers/browseByCategoryProvider.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowseByCategory extends StatefulWidget {
  final String catId;
  final String browseCategotyName;
  BrowseByCategory({
    this.catId,
    this.browseCategotyName,
  });
  @override
  _BrowseByCategoryState createState() => _BrowseByCategoryState();
}

class _BrowseByCategoryState extends State<BrowseByCategory>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  MyColors mycolor = new MyColors();
  List<String> categotyFilters = ["Best Match", "Recent", "Views"];

  @override
  void initState() {
    if (widget.catId != null) {
      Provider.of<BrowseByCategoryProvider>(context, listen: false)
          .fetchDataById(int.parse(widget.catId));
    } else {
      Provider.of<BrowseByCategoryProvider>(context, listen: false)
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
          searchToPage: (String searchText) {
            Provider.of<BrowseByCategoryProvider>(context, listen: false)
                .fetchDataByName(searchText);
          },
        ),
      ),
      body: Consumer<BrowseByCategoryProvider>(
        builder: (context, browseByCategoryProvider, child) {
          List<SearchSessionListByCategory> searchSessionList =
              browseByCategoryProvider.searchSessionList;
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
                              child: Text(
                                '${categotyFilters[i]}',
                                textAlign: TextAlign.center,
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
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: sessioncarGridLength,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LiveStreamScreen(
                                  StreamModel(
                                    id: searchSessionList[index].id.toString(),
                                    sessionId:
                                        searchSessionList[index].sessionId,
                                    sellerId: searchSessionList[index].sellerId,
                                    img: "ffgcf",
                                    shopName: searchSessionList[index].shopName,
                                    status: "ffgcf",
                                    logo: searchSessionList[index].shopLogo,
                                    category: "ffgcf",
                                    title: searchSessionList[index].sessionName,
                                    watching: searchSessionList[index].watching,
                                    date: "ffgcf",
                                    time: "ffgcf",
                                    timePassed: "ffgcf",
                                    videoLink:
                                        searchSessionList[index].videoLink,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: BrowsByCategoryStreamHelper(
                            searchResult: searchSessionList[index],
                          ),
                        );
                      },
                    ),
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
