import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';

class SubmitButtonComponent extends StatefulWidget {
  final String _buttonText;
  final Function _onClickFunction;

  const SubmitButtonComponent(this._buttonText, this._onClickFunction);

  @override
  _SubmitButtonComponentState createState() => _SubmitButtonComponentState();
}

class _SubmitButtonComponentState extends State<SubmitButtonComponent> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: LinearGradient(
            colors: [
              MyColors().blueDark,
              MyColors().blueLight,
            ],
          ),
        ),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const StadiumBorder(),
          child: Text(
            widget._buttonText,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            widget._onClickFunction();
          },
        ),
      ),
    );
  }
}
