import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/landing/Helpers/SearchBar.dart';
import 'package:aigolive/stores/models/storeSessionModel.dart';
import 'package:aigolive/stores/providers/frontStoreSessionProvider.dart';
import 'package:aigolive/stores/widgets/storeSessionWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllStoreSession extends StatefulWidget {
  @override
  _AllStoreSessionState createState() => _AllStoreSessionState();
}

class _AllStoreSessionState extends State<AllStoreSession> {
  List<String> sessionFilters = ["Popular", "Recent"];

  @override
  void initState() {
    super.initState();
    Provider.of<FrontStoreSessionProvider>(context, listen: false)
        .activeProductFilterIndex = 0;
    Provider.of<FrontStoreSessionProvider>(context, listen: false)
        .activeSessionFilterIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: SearchBar(
          isbackNav: false,
          isSearchIcon: false,
          isSearchField: false,
          ifNoSearchStringToDisplay: "Session",
          iconColor: Colors.white,
        ),
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
      body: Consumer<FrontStoreSessionProvider>(
        builder: (context, storeSessionProvider, child) {
          StoreSession storeSessionResult =
              storeSessionProvider.storeSessionData;
          List<StorefrontSessionList> sessionList =
              storeSessionProvider.storeSessionList;
          int fetchStatus = storeSessionProvider.fetchStatus;
          int activeFilterIndex = storeSessionProvider.activeSessionFilterIndex;

          switch (fetchStatus) {
            case 200:
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: List.generate(
                            sessionFilters.length,
                            (i) => Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  storeSessionProvider.filterSessions(
                                      sessionFilters[i], i);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey[400],
                                      ),
                                      right: i == 1
                                          ? BorderSide(
                                              color: Colors.grey[400],
                                            )
                                          : BorderSide.none,
                                      left: i == 1
                                          ? BorderSide(
                                              color: Colors.grey[400],
                                            )
                                          : BorderSide.none,
                                      bottom: BorderSide(
                                        color: i == activeFilterIndex
                                            ? MyColors().iconColor
                                            : Colors.grey[400],
                                        width:
                                            i == activeFilterIndex ? 2.0 : 1.0,
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    '${sessionFilters[i]}',
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: sessionList.length,
                          itemBuilder: (context, index) {
                            return StoreSessionWidget(
                              storeDetails: storeSessionResult,
                              storeSessionData: sessionList[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
              break;
            case 0:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              return Center(
                child: Text("Error"),
              );
          }
        },
      ),
    );
  }
}
