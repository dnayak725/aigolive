import 'dart:convert';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/landing/screens/Home.dart';
import 'package:aigolive/pre-login/components/SubmitButtonComponent.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/pre-login/components/centered_logo_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;
  final TextEditingController fullNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController cPasswordController = new TextEditingController();
  final TextEditingController phoneNumberController =
      new TextEditingController();
  final TextEditingController calendarController = new TextEditingController();
  String _phoneNumber;
  bool _isValidPhoneNumber = false;

  bool termsValue = false;
  bool _passwordVisible = true;
  bool _cPasswordVisible = true;

  bool _isFormDataMissed = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var number;
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   leading: AppBarPopButton(),
      //   title: Text(''),
      // ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       colors: [Colors.white, Colors.grey],
        //       begin: Alignment.center,
        //       end: Alignment.bottomCenter),
        // ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyHomePage()),
                                (Route<dynamic> route) => false);
                          },
                        )
                      ],
                    ),
                  ),
                  CenteredLogoComponent(true),
                  // textSection(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: fullNameController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            // icon: Icon(Icons.tag_faces,
                            //     color: Theme.of(context).primaryColor),
                            labelText: "Full Name*",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: emailController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black87),
                          validator: _emailValidator,
                          decoration: InputDecoration(
                            // icon: Icon(Icons.email,
                            //     color: Theme.of(context).primaryColor),
                            labelText: "Email*",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.white,
                          obscureText: _passwordVisible,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            // icon: Icon(Icons.lock,
                            //     color: Theme.of(context).primaryColor),
                            labelText: "Password*",

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
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: cPasswordController,
                          cursorColor: Colors.white,
                          obscureText: _cPasswordVisible,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            // icon: Icon(Icons.lock,
                            //     color: Theme.of(context).primaryColor),
                            labelText: "Confirm Password*",
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
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: calendarController,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            // icon: Icon(Icons.lock,
                            //     color: Theme.of(context).primaryColor),
                            labelText: "Date of Birth*",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyle(color: Colors.black38),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_today_rounded,
                                color: Color.fromARGB(255, 255, 153, 85),
                              ),
                              onPressed: _presentDatePicker,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(0, 83, 79, 1),
                                      width: 1.0))),
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Phone Number *'),
                              InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  print(number.phoneNumber);
                                  _phoneNumber = number.phoneNumber;
                                },
                                onInputValidated: (bool value) {
                                  print(value);
                                  _isValidPhoneNumber = value;
                                },
                                selectorConfig: SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                  // backgroundColor: Colors.black,
                                ),
                                ignoreBlank: true,
                                autoValidateMode: AutovalidateMode.always,
                                selectorTextStyle:
                                    TextStyle(color: Colors.black),
                                initialValue: number,
                                textFieldController: phoneNumberController,
                                hintText: "",
                                inputBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: termsValue,
                                activeColor: MyColors().iconColor,
                                onChanged: (bool value) {
                                  setState(() {
                                    termsValue = value;
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  'I want to receive exclusive offers and promotions from AiGo Live',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // buttonSection(),
                  // _getSignUpButton(),
                  SubmitButtonComponent('SignUp', _submitSignupForm),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    margin: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'By clicking Sign Up, you are including that you have road and acknowledge the Terms od service and Privacy Policy.',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: 'Already member? ',
                        // style: Theme.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: MyColors().textButton,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => navigateToSignUpScreen(),
                          ),
                          TextSpan(text: ' here.'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  )
                ],
              ),
      ),
    );
  }

  Widget _getSignUpButton() {
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
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            print(fullNameController.text);
            if (fullNameController.text == "") {
              _isFormDataMissed = true;
            } else {
              _isFormDataMissed = false;
            }
            if (emailController.text == "") {
              _isFormDataMissed = true;
            } else {
              _isFormDataMissed = false;
            }
            if (passwordController.text == "") {
              _isFormDataMissed = true;
            } else {
              _isFormDataMissed = false;
            }
            if (cPasswordController.text == "") {
              _isFormDataMissed = true;
            } else {
              _isFormDataMissed = false;
            }
            if (calendarController.text == "") {
              _isFormDataMissed = true;
            } else {
              _isFormDataMissed = false;
            }
            if (fullNameController.text == "") {
              _isFormDataMissed = true;
            } else {
              _isFormDataMissed = false;
            }

            if (_isFormDataMissed != true) {
              setState(() {
                _isLoading = true;
              });
              Map<String, dynamic> profileBody = {
                "ID": 0,
                "FIRST_NAME": fullNameController.text,
                "LAST_NAME": "AAA11",
                "PICTURE": "",
                "EMAIL": emailController.text,
                "MOBILE_NO": _phoneNumber,
                "PASSWORD": passwordController.text,
                "DOB": calendarController.text,
                "GENDER": "",
                "COUNTRY": "",
                "BILLING_ADDRESS": "",
                "SHIPPING_ADDRESS": "",
                "INTEREST": "shop",
                "LAST_ACTIVE": "",
                "STATUS": 1,
                "CREATED_BY": 1,
                "UPDATED_BY": 0
              };
              if (userRegister(profileBody) == true) {
                // Navigator.pop(context);
              } else {
                setState(() {
                  _isLoading = false;
                });
              }
            }
          },
        ),
      ),
    );
  }

  _submitSignupForm() {
    print('object');
    if (fullNameController.text == "") {
      _isFormDataMissed = true;
    } else {
      _isFormDataMissed = false;
    }
    if (emailController.text == "") {
      _isFormDataMissed = true;
    } else {
      _isFormDataMissed = false;
    }
    if (passwordController.text == "") {
      _isFormDataMissed = true;
    } else {
      _isFormDataMissed = false;
    }
    if (cPasswordController.text == "") {
      _isFormDataMissed = true;
    } else {
      _isFormDataMissed = false;
    }
    if (calendarController.text == "") {
      _isFormDataMissed = true;
    } else {
      _isFormDataMissed = false;
    }
    if (fullNameController.text == "") {
      _isFormDataMissed = true;
    } else {
      _isFormDataMissed = false;
    }

    if (_isFormDataMissed != true) {
      setState(() {
        _isLoading = true;
      });
      //split full name with first and last name
      var names = fullNameController.text.split(" ");
      var fName = "";
      var lName = "";
      for (int i = 0; i < names.length; i++) {
        if (i == 0) {
          fName = names[i];
        } else {
          lName = names[i] + " ";
        }
      }
      Map<String, dynamic> profileBody = {
        "ID": 0,
        "FIRST_NAME": fName,
        "LAST_NAME": lName,
        "PICTURE": "",
        "EMAIL": emailController.text,
        "MOBILE_NO": _phoneNumber,
        "norM_PASSWORD": passwordController.text,
        "DOB": calendarController.text,
        "GENDER": "M",
        "COUNTRY": "1",
        "BILLING_ADDRESS": "",
        "SHIPPING_ADDRESS": "",
        "INTEREST": "1",
        "LAST_ACTIVE": "1998-12-02",
        "STATUS": 1,
        "CREATED_BY": 1,
        "UPDATED_BY": 0
      };
      userRegister(profileBody);
    }
  }

  Future userRegister(profileBody) async {
    final response = await http.post(
      AppConfig().apiLink + 'Customer/RegisterCustomer',
      headers: {
        "Content-Type": "application/json",
        "ApiKey": "cDa98K42-79eb-4B31-9I32-4b060Ff11557"
      },
      body: jsonEncode(profileBody),
    );
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      var results = json.decode(response.body);
      print(results);

      if (results['status'] == "success") {
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text('Registration successful.'),
          ),
        );
        // Navigator.pop(context);
      } else {
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(results['status']),
          ),
        );
      }
    } else {
      print(response.statusCode);
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text('Registration failure.'),
        ),
      );
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // _selectedDate = pickedDate;
        calendarController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
      });
    });
    // print('...');
  }

  navigateToSignUpScreen() {
    //signup screen
    Navigator.of(context).pop();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => SignupScreen()),
    //         (Route<dynamic> route) => false);
  }

  String _emailValidator(String value) {
    return value;
  }
}
