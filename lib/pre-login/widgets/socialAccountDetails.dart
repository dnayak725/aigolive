import 'dart:convert';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/landing/screens/Home.dart';
import 'package:aigolive/pre-login/components/SubmitButtonComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialAccountDetails extends StatefulWidget {
  final String userId;
  final String email;
  final String phone;
  final String dob;
  SocialAccountDetails({
    @required this.userId,
    @required this.email,
    @required this.phone,
    @required this.dob,
  });
  @override
  _SocialAccountDetailsState createState() => _SocialAccountDetailsState();
}

class _SocialAccountDetailsState extends State<SocialAccountDetails> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();
  DateTime selectedDate = DateTime.now();

  _showAlertDialog(String alertText, String msg, String buttonText) {
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

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    dobController.text = widget.dob;
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.email == ""
              ? TextFormField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.black38),
                  ),
                )
              : SizedBox(),
          widget.email == "" ? SizedBox(height: 30.0) : SizedBox(),
          widget.phone == ""
              ? TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.black38),
                  ),
                )
              : SizedBox(),
          widget.phone == "" ? SizedBox(height: 30.0) : SizedBox(),
          widget.dob == ""
              ? TextFormField(
                  onTap: () => _selectDate(context),
                  controller: dobController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: "Date Of Birth",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    hintStyle: TextStyle(color: Colors.black38),
                  ),
                )
              : SizedBox(),
          widget.dob == "" ? SizedBox(height: 30.0) : SizedBox(),
          SubmitButtonComponent(
            "Login",
            () async {
              if (emailController.text != "" &&
                  phoneController.text != "" &&
                  dobController.text != "") {
                if (phoneController.text.length == 10) {
                  await Provider.of<UserProfileProvider>(context, listen: false)
                      .updateEmail(widget.userId, emailController.text);
                  await Provider.of<UserProfileProvider>(context, listen: false)
                      .updateProfile(widget.userId, dobController.text,
                          phoneController.text);
                  var email =
                      Provider.of<UserProfileProvider>(context, listen: false)
                          .email;
                  var dob =
                      Provider.of<UserProfileProvider>(context, listen: false)
                          .dob;
                  var phone =
                      Provider.of<UserProfileProvider>(context, listen: false)
                          .mobileNumber;
                  if (email != "" || dob != "" || phone != "") {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage()),
                        (Route<dynamic> route) => false);
                  }
                } else {
                  _showAlertDialog("Alert !",
                      'Phone number should be of 10 digits only', "Try Again");
                }
              } else {
                _showAlertDialog(
                    "Alert !", 'All fields are mandaroty', "Try Again");
              }
            },
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var pickedDate = DateFormat('y-M-d').format(picked);
        var date = pickedDate;
        dobController.text = date;
      });
  }
}
