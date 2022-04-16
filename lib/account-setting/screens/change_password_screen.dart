import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController cPasswordController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController oldPasswordController =
      new TextEditingController();
  bool _passwordVisible = true;
  bool _cPasswordVisible = true;
  bool _oldPasswordVisible = true;
  String _userId = "";
  bool _isLoading = true;
  syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      setState(() {
        _userId = sharedPreferences.getString("user_id");
        Provider.of<UserProfileProvider>(context, listen: false)
            .fetchData(_userId);
        _isLoading = false;
      });
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    syncData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AccountBarPopButton(),
        title: Text('Reset Password'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [MyColors().blueDark, MyColors().blueLight],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin: EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      controller: oldPasswordController,
                      cursorColor: Colors.white,
                      obscureText: _oldPasswordVisible,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        // icon: Icon(Icons.lock,
                        //     color: Theme.of(context).primaryColor),
                        labelText: "Current Password *",
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        hintStyle: TextStyle(color: Colors.black38),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _oldPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color.fromARGB(255, 255, 153, 85),
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _oldPasswordVisible = !_oldPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin: EdgeInsets.only(top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please enter your new password below',
                        ),
                        Text(
                          'Minimum 6 characters with a number and a letter',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                    width: MediaQuery.of(context).size.width,
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
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: _getSubmitButton(),
      ),
    );
  }

  Widget _getSubmitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: LinearGradient(
            colors: [Color(0xFF2c347d), Color(0xFF36a8e0)],
          ),
        ),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const StadiumBorder(),
          child: Text(
            'Change Password',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            changePaswword();
          },
        ),
      ),
    );
  }

  changePaswword() async {
    setState(() {
      _isLoading = true;
    });
    if (oldPasswordController.text == "" ||
        passwordController.text == "" ||
        cPasswordController.text == "") {
      _showAlertDialog(
          "Please fill in all the fields.", "Try again", "Alert!!");
    } else {
      if (passwordController.text == cPasswordController.text) {
        final response = await http.post(
          AppConfig().apiLink + "Customer/PostBuyerPassword",
          headers: {
            "Content-Type": "application/json",
            "ApiKey": AppConfig().apiKey,
          },
          body: jsonEncode({
            "ID": int.parse(_userId),
            "PASSWORD": oldPasswordController.text,
            "normPassword": passwordController.text
          }),
        );
        if (response.statusCode == 200) {
          _showAlertDialog("Your Password has been changed!", "OK", "Success!");
          oldPasswordController.text = "";
          passwordController.text = "";
          cPasswordController.text = "";
        } else
          _showAlertDialog(
              "Failed to save your new password.", "Try again", "Alert!!");
      } else {
        _showAlertDialog("New password and confirm password does not match.",
            "Try again", "Alert!!");
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  _showAlertDialog(String msg, String buttonText, String alertText) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertText),
          content: Text(msg),
          actions: [
            FlatButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
