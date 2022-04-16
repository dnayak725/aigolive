import 'package:flutter/material.dart';

class CenteredLogoComponent extends StatelessWidget{
  final isBlackLogo;

  const CenteredLogoComponent(this.isBlackLogo);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 30.0),
      // padding: EdgeInsets.all(30),
      child: isBlackLogo?Image.asset(
        'assets/images/Logo-Black.png',
        fit: BoxFit.cover,
        width: 150,
      ): Image.asset(
        'assets/images/Logo-white.png',
        fit: BoxFit.cover,
        width: 150,
      ),
    );
  }

}