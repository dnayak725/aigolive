import 'package:flutter/material.dart';

class AccountBarPopButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      icon: Icon(Icons.chevron_left_sharp),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

}