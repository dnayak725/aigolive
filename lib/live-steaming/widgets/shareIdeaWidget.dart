import 'package:aigolive/account-setting/bookmark/models/bookmarkedSessionModel.dart';
import 'package:aigolive/account-setting/bookmark/providers/bookmarkedSessionProvider.dart';
import 'package:aigolive/live-steaming/models/SessionDetailsProductsModel.dart';
import 'package:aigolive/live-steaming/providers/SessionDetailsProductsProvider.dart';
import 'package:aigolive/live-steaming/providers/userMessageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareIdeaWidget extends StatefulWidget {
  final TextEditingController shareIdeaInputController;
  final String sessionId;
  const ShareIdeaWidget(
      {Key key, this.shareIdeaInputController, this.sessionId})
      : super(key: key);
  @override
  _ShareIdeaWidgetState createState() => _ShareIdeaWidgetState();
}

class _ShareIdeaWidgetState extends State<ShareIdeaWidget> {
  syncData() async {
    await Provider.of<BookMarkedSessionProvider>(context, listen: false)
        .getLocalUserId();
    await Provider.of<SessionDetailsProductsProvider>(context, listen: false)
        .fetchData(widget.sessionId);
  }

  @override
  void initState() {
    super.initState();
    syncData();
  }

  @override
  Widget build(BuildContext context) {
    return (MediaQuery.of(context).orientation == Orientation.portrait)
        ? Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 30) * 0.7,
                  child: TextFormField(
                    controller: widget.shareIdeaInputController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Share you ideas",
                      focusColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 30) * 0.15,
                  child: MaterialButton(
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 0,
                        color: Colors.white,
                      ),
                    ),
                    child: Image.asset(
                      "assets/images/share-icon.png",
                      height: 20,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      if (widget.shareIdeaInputController.text != '') {
                        Provider.of<UserMessageProvider>(context, listen: false)
                            .addNewMessage(widget.sessionId,
                                widget.shareIdeaInputController.text);
                      }
                      widget.shareIdeaInputController.text = '';
                    },
                  ),
                ),
                Consumer<BookMarkedSessionProvider>(
                  builder: (context, bookMarkedSession, child) {
                    var localUserId = bookMarkedSession.localUserId;
                    List<BookmarkedSessionModel> allBookmarks =
                        bookMarkedSession.bookmarkedSessionList;
                    if (localUserId != null) {
                      bool isBookMarked = allBookmarks.any(
                          (element) => element.sessionId == widget.sessionId);
                      return Consumer<SessionDetailsProductsProvider>(
                          builder: (context, sessionDetails, child) {
                        SessionDetailsProductsModel sessionDetailsModel =
                            sessionDetails.sessionDetails;
                        return sessionDetailsModel != null
                            ? Container(
                                width:
                                    (MediaQuery.of(context).size.width - 30) *
                                        0.15,
                                // color: Colors.red,
                                child: Stack(
                                  children: [
                                    MaterialButton(
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          width: 0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Image.asset(
                                        isBookMarked
                                            ? "assets/images/bookmark_active.png"
                                            : "assets/images/bookmark_inactive.png",
                                        height: 20,
                                      ),
                                      // child: Icon(
                                      //   Icons.circle,
                                      //   color: Colors.red,
                                      //   size: 20,
                                      // ),
                                      color: Colors.white,
                                      onPressed: () {
                                        isBookMarked
                                            ? bookMarkedSession
                                                .removeOrAddSession(
                                                    widget.sessionId,
                                                    sessionDetailsModel
                                                        .sellerId,
                                                    false)
                                            : bookMarkedSession
                                                .removeOrAddSession(
                                                    widget.sessionId,
                                                    sessionDetailsModel
                                                        .sellerId,
                                                    true);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox();
                      });
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          )
        : Container(
            child: Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width * 0.8 - 30) * 0.7,
                  child: TextFormField(
                    controller: widget.shareIdeaInputController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Share you ideas",
                      focusColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width * 0.8 - 30) * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // color: Colors.red,
                        width: 50,
                        child: MaterialButton(
                          shape: CircleBorder(
                              side: BorderSide(
                            width: 0,
                            color: Colors.white,
                          )),
                          child: Image.asset(
                            "assets/images/share-icon.png",
                            height: 20,
                            width: 20,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            if (widget.shareIdeaInputController.text != '') {
                              // Provider.of<UserMessageProvider>(context,
                              //         listen: false)
                              //     .addNewMessage(
                              //         widget.shareIdeaInputController.text);
                            }

                            widget.shareIdeaInputController.text = '';
                          },
                        ),
                      ),
                      Container(
                        width: 50,
                        child: Stack(
                          children: [
                            MaterialButton(
                              shape: CircleBorder(
                                  side: BorderSide(
                                width: 0,
                                color: Colors.white,
                              )),
                              child: Image.asset(
                                "assets/images/bookmark_active.png",
                                height: 20,
                                width: 20,
                              ),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            Positioned(
                              left: 15,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 2),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Color(0xFF2f5a9e),
                                ),
                                child: Text(
                                  '1.8k',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
