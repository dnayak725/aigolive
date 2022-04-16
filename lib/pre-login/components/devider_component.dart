import 'package:flutter/material.dart';

class DeviderComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(children: <Widget>[
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ),
        Text("or"),
        Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ),
      ]),
    );
  }

}