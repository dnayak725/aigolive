import 'package:flutter/material.dart';
import 'package:share/share.dart';

class StreamHelper extends StatefulWidget {
  final String streamImage;
  final String streamTitle;
  final String totalWatched;
  final String timePassed;
  StreamHelper({
    @required this.streamImage,
    @required this.streamTitle,
    @required this.totalWatched,
    @required this.timePassed,
  });
  @override
  _StreamHelperState createState() => _StreamHelperState();
}

class _StreamHelperState extends State<StreamHelper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 30) * .42,
                height: (MediaQuery.of(context).size.width - 30) * .42,
                margin: EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    image: AssetImage(widget.streamImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 0, bottom: 4, top: 4),
            width: (MediaQuery.of(context).size.width - 30) * .42,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          widget.streamTitle,
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
                    "shp name shop name shop name",
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
                      text: '${widget.totalWatched} watched',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 8.0,
                      ),
                      children: [
                        TextSpan(
                          text: ' . ',
                        ),
                        TextSpan(
                          text: widget.timePassed,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
