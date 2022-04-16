import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';

class AlertBoxComponent extends StatelessWidget {
  final String _title;
  final String _desc;

  const AlertBoxComponent(this._title, this._desc);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black38,
      child: Center(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 200,
              width: MediaQuery.of(context).size.width - 30,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(_desc),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    color: MyColors().orderCancelButtonColor,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  )
                ],
              ))),
    );
  }
}
