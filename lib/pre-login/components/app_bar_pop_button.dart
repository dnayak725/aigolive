import 'package:flutter/material.dart';

class AppBarPopButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chevron_left_sharp),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

}