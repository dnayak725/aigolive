import 'package:aigolive/config/colors.dart';
import 'package:aigolive/pre-login/components/app_bar_pop_button.dart';
import 'package:aigolive/pre-login/components/centered_logo_component.dart';
import 'package:flutter/material.dart';

class SaveNewPasswordSceen extends StatefulWidget{
  @override
  _SaveNewPasswordSceenState createState() => _SaveNewPasswordSceenState();
}

class _SaveNewPasswordSceenState extends State<SaveNewPasswordSceen> {

  final TextEditingController cPasswordController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _passwordVisible = true;
  bool _cPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            child: TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              obscureText: _passwordVisible,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                // icon: Icon(Icons.lock,
                //     color: Theme.of(context).primaryColor),
                labelText: "New Password *",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.black38),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Color.fromARGB(255, 255, 153, 85),
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
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
              controller: cPasswordController,
              cursorColor: Colors.white,
              obscureText: _cPasswordVisible,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                // icon: Icon(Icons.lock,
                //     color: Theme.of(context).primaryColor),
                labelText: "Retype Password *",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.black38),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _cPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Color.fromARGB(255, 255, 153, 85),
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _cPasswordVisible = !_cPasswordVisible;
                      });
                    },
                  ),
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
            'Save',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}