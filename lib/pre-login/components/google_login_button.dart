import 'package:flutter/material.dart';

class GoogleLoginButton extends StatelessWidget {
  final Function _googleSignin;
  final String _showText;

  const GoogleLoginButton(this._showText, this._googleSignin);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.only(top: 8.0),
        child: RaisedButton(
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 6),
          elevation: 3,
          color: Colors.white,
          onPressed: () {
            _googleSignin();
          },
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 25.0,
                height: 25.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    image: AssetImage('assets/images/google-icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8 - 30,
                // color: Colors.red,
                child: Center(
                  child: Text(
                    _showText,
                    style: TextStyle(
                      // fontSize: 20,
                      // fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
    );
  }
}
