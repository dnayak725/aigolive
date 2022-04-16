import 'package:aigolive/landing/models/searchSessionListByCategory.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class BrowsByCategoryStreamHelper extends StatefulWidget {
  final SearchSessionListByCategory searchResult;

  BrowsByCategoryStreamHelper({
    this.searchResult,
  });

  @override
  _BrowsByCategoryStreamHelperState createState() =>
      _BrowsByCategoryStreamHelperState();
}

class _BrowsByCategoryStreamHelperState
    extends State<BrowsByCategoryStreamHelper> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    image: NetworkImage(widget.searchResult.sessionThumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                          widget.searchResult.sessionName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Share.share(widget.searchResult.pageLink),
                      child: Icon(
                        Icons.more_vert,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    widget.searchResult.shopName,
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
                      text: '${widget.searchResult.watching} watched',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 8.0,
                      ),
                      children: [
                        TextSpan(
                          text: ' . ',
                        ),
                        TextSpan(
                          text:
                              "${widget.searchResult.daysMonth} ${widget.searchResult.textDays} ago",
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
