import 'package:aigolive/config/colors.dart';
import 'package:aigolive/pre-login/components/app_bar_pop_button.dart';
import 'package:aigolive/pre-login/components/centered_logo_component.dart';
import 'package:aigolive/pre-login/screens/save_new_password_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: ForgotPasswordScreen implement build
    return Scaffold(
        appBar: AppBar(
          leading: AppBarPopButton(),
          title: Text('Reset Password'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    MyColors().blueDark,
                    MyColors().blueLight
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            CenteredLogoComponent(true),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                'Please enter the account that you want to reset the password.',
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.only(top: 15.0),
              child: TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  // icon: Icon(Icons.email,
                  //     color: Theme.of(context).primaryColor),
                  labelText: "E-mail / Mobile Number *",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  hintStyle: TextStyle(color: Colors.black38),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: _getSubmitButton(),),
    );
  }

  Widget _getSubmitButton() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: LinearGradient(
            colors: [
              Color(0xFF2c347d),
              Color(0xFF36a8e0)
            ],
          ),
        ),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const StadiumBorder(),
          child: Text(
            'Reset Password',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SaveNewPasswordSceen()),
            );
          },
        ),
      ),
    );
  }
}
