import 'package:aigolive/landing/models/searchSessionListByCategory.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BannerTagStreamHelper extends StatefulWidget {
  final SearchSessionListByCategory bannerTag;
  BannerTagStreamHelper({
    @required this.bannerTag,
  });
  @override
  _BannerTagStreamHelperState createState() => _BannerTagStreamHelperState();
}

class _BannerTagStreamHelperState extends State<BannerTagStreamHelper> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LiveStreamScreen(
              StreamModel(
                  id: widget.bannerTag.id.toString(),
                  sessionId: widget.bannerTag.sessionId,
                  sellerId: widget.bannerTag.sellerId,
                  img: "ffgcf",
                  shopName: widget.bannerTag.shopName,
                  status: "ffgcf",
                  logo: widget.bannerTag.shopLogo,
                  category: "ffgcf",
                  title: widget.bannerTag.sessionName,
                  watching: widget.bannerTag.watching,
                  date: "ffgcf",
                  time: "ffgcf",
                  timePassed: "ffgcf",
                  videoLink: widget.bannerTag.videoLink),
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
                  // margin: EdgeInsets.symmetric(
                  //   horizontal: 6,
                  // ),
                  decoration: new BoxDecoration(
                    // color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                    image: new DecorationImage(
                      image: NetworkImage(widget.bannerTag.sessionThumbnail),
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
                            widget.bannerTag.sessionName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Share.share("Text here"),
                        child: Icon(
                          Icons.more_vert,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      widget.bannerTag.shopName,
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
                        text: '${widget.bannerTag.totalSessionWatching} Watching',
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
