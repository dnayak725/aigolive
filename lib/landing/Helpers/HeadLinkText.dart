
import 'package:aigolive/landing/components/Enums.dart';

import 'package:flutter/material.dart';

class HeadLinkText extends StatelessWidget {
  final String heading;
  final MainAxisAlignment headingAlign;
  final String linkText;
  final NavigateToPage secKey;
  final double padding;
  final Color headColor;
  final Color linkColor;
  final BuildContext pageContext;
  final Function pageNavigation;
  HeadLinkText({
    @required this.heading,
    this.headingAlign = MainAxisAlignment.spaceBetween,
    this.secKey,
    this.linkText = '',
    this.padding = 0,
    @required this.headColor,
    this.linkColor,
    this.pageContext,
    this.pageNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: padding, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: headingAlign,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 20,
              color: headColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          linkText != '' && secKey != null && pageNavigation != null
              ? GestureDetector(
                  onTap: () {
                    pageNavigation();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        linkText,
                        style: TextStyle(
                          fontSize: 15,
                          color: linkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: linkColor,
                        size: 14,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
