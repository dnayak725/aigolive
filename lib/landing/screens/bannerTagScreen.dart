import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/BannerTagStreamHelper.dart';
import 'package:aigolive/landing/models/searchSessionListByCategory.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/landing/providers/bannerTagStreamProvider.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerTagScreen extends StatefulWidget {
  final String categoryName;
  final String catId;
  BannerTagScreen({
    this.categoryName,
    this.catId,
  });
  @override
  _BannerTagScreenState createState() => _BannerTagScreenState();
}

class _BannerTagScreenState extends State<BannerTagScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  MyColors mycolor = new MyColors();
  List<String> categotyFilters = ["Best Match", "Recent", "Views"];
  int activeFilterIndex = 0;

  void filterProducts(filterValue, filterIndex) {
    setState(() {
      activeFilterIndex = filterIndex;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
    Provider.of<BannerTagStreamProvider>(context, listen: false)
        .fetchDataById(int.parse(widget.catId));
    // .fetchDataById(15);
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
        elevation: 0.0,
        title: Text(widget.categoryName),
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
      body: Consumer<BannerTagStreamProvider>(
        builder: (context, valentineProvider, child) {
          List<SearchSessionListByCategory> streamList =
              valentineProvider.searchSessionList;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: GridView.builder(
                physics: ScrollPhysics(),
                itemCount: streamList.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                controller: new ScrollController(keepScrollOffset: false),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveStreamScreen(
                            StreamModel(
                              id: streamList[index].id.toString(),
                              sessionId: streamList[index].sessionId,
                              sellerId: streamList[index].sellerId,
                              img: "ffgcf",
                              shopName: streamList[index].shopName,
                              status: "ffgcf",
                              logo: streamList[index].shopLogo,
                              category: "ffgcf",
                              title: streamList[index].sessionName,
                              watching: streamList[index].watching,
                              date: "ffgcf",
                              time: "ffgcf",
                              timePassed: "ffgcf",
                              videoLink: streamList[index].videoLink,
                            ),
                          ),
                        ),
                      );
                    },
                    child: BannerTagStreamHelper(
                      bannerTag: streamList[index],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
