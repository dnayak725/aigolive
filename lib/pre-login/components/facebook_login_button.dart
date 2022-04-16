import 'package:flutter/material.dart';

class FacebookLoginButton extends StatelessWidget {
  final String _showText;
  final Function _facebookLogin;

  const FacebookLoginButton(this._showText, this._facebookLogin);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: RaisedButton(
          padding: EdgeInsets.only(top: 3, bottom: 3, left: 6),
          elevation: 3,
          color: Color.fromRGBO(59, 89, 152, 1),
          onPressed: () {
            _facebookLogin();
          },
          child: Row(
            children: <Widget>[
              Container(
                width: 25.0,
                height: 25.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    image: AssetImage('assets/images/facebook-icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8 - 30,
                child: Center(
                  child: Text(
                    _showText,
                    style: TextStyle(
                      color: Colors.white,
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
