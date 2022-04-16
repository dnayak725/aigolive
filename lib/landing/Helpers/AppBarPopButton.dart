import 'package:flutter/material.dart';

class AppBarPopButton extends StatelessWidget {
  // final Color backNavColor;
  // AppBarPopButton({
  //   this.backNavColor = const Color(chevron_left_sharp),
  // });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.chevron_left,
        // color: backNavColor,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
