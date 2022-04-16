import 'package:flutter/material.dart';

class ProductDetailsLoadingPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height*0.5,
        // height: (MediaQuery.of(context).size.width - 30) * .62,
        margin: EdgeInsets.only(
    top: 6, left: 15, right: 15, bottom: 20
        ),
        decoration: new BoxDecoration(
    // border: Border.all(width: 1),
    color: Colors.blue,
    shape: BoxShape.rectangle,
    image: new DecorationImage(
      image: AssetImage("assets/images/loading-preview.gif"),
      fit: BoxFit.fill,
    ),
        ),
      );
  }
}
