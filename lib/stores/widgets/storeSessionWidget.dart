import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:aigolive/stores/models/storeSessionModel.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class StoreSessionWidget extends StatefulWidget {
  final StoreSession storeDetails;
  final StorefrontSessionList storeSessionData;
  StoreSessionWidget({
    @required this.storeDetails,
    @required this.storeSessionData,
  });
  @override
  _StoreSessionWidgetState createState() => _StoreSessionWidgetState();
}

class _StoreSessionWidgetState extends State<StoreSessionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LiveStreamScreen(
              StreamModel(
                id: widget.storeSessionData.id,
                sessionId: widget.storeSessionData.id,
                sellerId: widget.storeSessionData.sellerId,
                img: "ffgcf",
                shopName: widget.storeDetails.shopName,
                status: "ffgcf",
                logo: widget.storeDetails.logo,
                category: "ffgcf",
                title: widget.storeSessionData.sessionName,
                watching: widget.storeSessionData.watching,
                date: "ffgcf",
                time: "ffgcf",
                timePassed: "ffgcf",
                videoLink: widget.storeSessionData.videoLink,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  // width: (MediaQuery.of(context).size.width + 10) * .42,
                  height: (MediaQuery.of(context).size.width - 30) * .42,
                  decoration: new BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      image: NetworkImage(
                          widget.storeSessionData.sessionThumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   top: 5,
                //   right: 10,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                //     decoration: new BoxDecoration(
                //       color: Colors.red,
                //     ),
                //     child: Text(
                //       "LIVE",
                //       style: TextStyle(color: Colors.white, fontSize: 10),
                //     ),
                //   ),
                // ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 5, bottom: 4, top: 4, right: 3),
              // width: (MediaQuery.of(context).size.width / 2) - 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.storeSessionData.sessionName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Share.share(widget.storeSessionData.pageLink),
                        child: Icon(
                          Icons.more_vert,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      widget.storeDetails.shopName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: '${widget.storeSessionData.watching} Watched',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
