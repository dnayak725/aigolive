import 'dart:convert';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/pre-login/components/SubmitButtonComponent.dart';
import 'package:aigolive/pre-login/components/centered_logo_component.dart';
import 'package:aigolive/pre-login/components/devider_component.dart';
import 'package:aigolive/pre-login/components/facebook_login_button.dart';
import 'package:aigolive/pre-login/components/google_login_button.dart';
import 'package:aigolive/pre-login/screens/forgot_password_screen.dart';
import 'package:aigolive/pre-login/screens/signup_screen.dart';
import 'package:aigolive/landing/screens/Home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  // final TextEditingController emailController =
  //     new TextEditingController(text: "sujit@quocent.com");
  // final TextEditingController passwordController =
  //     new TextEditingController(text: "123456");
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FacebookLogin facebookLogin = FacebookLogin();
  bool _passwordVisible = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          tooltip: 'Increase volume by 10',
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
                  //logo section start
                  CenteredLogoComponent(true),

                  // textSection(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
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
                        SizedBox(height: 30.0),
                        TextFormField(
                          controller: passwordController,
                          // cursorColor: Colors.white,
                          obscureText: _passwordVisible,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              // icon: Icon(Icons.lock,
                              //     color: Theme.of(context).primaryColor),
                              labelText: "Password *",
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
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
                              )),
                        ),
                      ],
                    ),
                  ),
                  // buttonSection(),

                  // _getLoginButton(),
                  SubmitButtonComponent('Login', () {
                    setState(() {
                      _isLoading = true;
                    });
                    signIn(
                      emailController.text,
                      passwordController.text,
                    );
                  }),

                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.5,
                    // alignment: Alignment.centerRight,
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.0,
                        vertical: 0,
                      ),
                      // textColor: Colors.blue,
                      child: Text(
                        'Forgot Password?',
                        // style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                    ),
                  ),
                  DeviderComponent(),
                  FacebookLoginButton("Login with Facebook", _facebookLogin),
                  GoogleLoginButton('Login with Google', _googleSignin),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: 'New to AiGo Live? ',
                        // style: Theme.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign Up',
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
                    height: 20,
                  ),
                ],
              ),
      ),
    );
  }

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

  _socialRegistration(fbOrGoogle, profileDetails) async {
    final response = await http.post(
      fbOrGoogle == "Facebook"
          ? ApiLinks().facebookRegistrationApi
          : ApiLinks().googleRegistrationApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "name": profileDetails['name'],
        "email": profileDetails['email'] ?? "",
        "dob": profileDetails['dob'] ?? "",
        "mobileNo": profileDetails['phone'] ?? "",
        "picture": profileDetails['fbImage'],
        "emailVerified": "true",
        "refreshToken": "gjjhjh",
        "accessToken": "uuuuhuuh",
      }),
    );
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        var results = json.decode(response.body);
        print(results);
        if (results['status'] == "success") {
          var data = results['data'];
          sharedPreferences.setString("status", results['status']);
          sharedPreferences.setString("user_id", data[0]['user_id'].toString());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage()),
              (Route<dynamic> route) => false);
        } else {
          _showAlertDialog("Alert !", results['msg'], "Try Again");
        }
        break;
      default:
        _showAlertDialog("Alert !", "Network Error", "Try Again");
        break;
    }
  }

  _googleSignin() async {
    try {
      await _googleSignIn.signIn();
      // await _googleSignIn.signInSilently();
      // setState(() {
      // _isLoggedIn = true;
      // });
      print(_googleSignIn.currentUser.displayName);
      print(_googleSignIn.currentUser.photoUrl);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString("token", 'token');
      sharedPreferences.setString("mode", 'GOOGLE');
      sharedPreferences.setString(
          "name", _googleSignIn.currentUser.displayName);
      sharedPreferences.setString(
          "photoUrl", _googleSignIn.currentUser.photoUrl);
      Map googleProfileDetails = {
        "name": _googleSignIn.currentUser.displayName,
        "fbImage": _googleSignIn.currentUser.photoUrl,
        "phone": null,
        "email": _googleSignIn.currentUser.email,
        "dob": null,
      };
      _socialRegistration("Google", googleProfileDetails);
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
      //     (Route<dynamic> route) => false);
      _googleSignIn.signOut();
    } catch (err) {
      print(err);
    }
  }

  Future<Null> _facebookLogin() async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    print("status:" + result.status.toString());
    print("error message:" + result.errorMessage.toString());
    //print("status:"+ result.accessToken.token.toString());
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        print("token =" + token.toString());
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile["picture"]["data"]["url"]);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", 'token');
        sharedPreferences.setString("mode", 'FACEBOOK');
        sharedPreferences.setString("name", profile["name"]);
        sharedPreferences.setString(
            "photoUrl", profile["picture"]["data"]["url"]);
        // print(profile);
        Map fbProfileDetails = {
          "name": profile["name"],
          "fbImage": profile["picture"]["data"]["url"],
          "phone": profile["phone"],
          "email": profile["email"],
          "dob": profile["dob"],
        };
        _socialRegistration("Facebook", fbProfileDetails);
        setState(() {
          // userProfile = profile;
          // _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        print("User cancelled");
        break;
      case FacebookLoginStatus.error:
        print("something went wrong");
        break;
    }
  }

  //sign in function
  signIn(String email, pass) async {
    final response = await http.post(
      AppConfig().apiLink + 'Customer/PostCustomer',
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey
      },
      body: jsonEncode({"EMAIL": email, "NORM_PASSWORD": pass}),
    );
    switch (response.statusCode) {
      case 200:
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          // var data = results['data'][0];
          sharedPreferences.setString(
              "user_id", results['data'][0]['user_id'].toString());
          sharedPreferences.setString("status", results['status'].toString());
          // print(sharedPreferences.getString("user_id") +
          //     ":" +
          //     sharedPreferences.getString("status"));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage()),
              (Route<dynamic> route) => false);
        } else {
          _scaffoldKey.currentState?.showSnackBar(
            SnackBar(
              content: const Text('Incorrect email or password.'),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ),
          );
        }
        break;
      case 400:
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text('400: Invalid Request.'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        );
        break;
      case 401:
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text("404: Forbidden"),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        );
        break;
      case 403:
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text("404: Forbidden"),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        );
        break;
      case 404:
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text("404: Not Found."),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        );
        break;
      case 500:
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text("404: Internal Server Error."),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        );
        break;
      default:
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
                'Error occured while Communication with Server with StatusCode : ${response.statusCode}'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
        );
        break;
    }
    setState(() {
      _isLoading = false;
    });
  }

  navigateToSignUpScreen() {
    //signup screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  Widget _getLoginButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: LinearGradient(
            colors: [MyColors().blueDark, MyColors().blueLight],
          ),
        ),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const StadiumBorder(),
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: emailController.text == "" || passwordController.text == ""
              ? () {}
              : () {
                  setState(() {
                    _isLoading = true;
                  });
                  signIn(
                    emailController.text,
                    passwordController.text,
                  );
                },
        ),
      ),
    );

    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: 40.0,
    //   padding: EdgeInsets.symmetric(horizontal: 15.0),
    //   margin: EdgeInsets.only(top: 15.0),
    //   child: Container(
    //     // contentPadding: EdgeInsets.symmetric(2.0,3.0),
    //     child: SizedBox(
    //       width: MediaQuery.of(context).size.width * 0.4,
    //       child: RaisedButton(
    //         onPressed: emailController.text == "" ||
    //             passwordController.text == ""
    //             ? () {}
    //             : () {
    //           setState(() {
    //             _isLoading = true;
    //           });
    //           signIn(
    //             emailController.text,
    //             passwordController.text,
    //           );
    //         },
    //         elevation: 3,
    //         color: Theme.of(context).primaryColor,
    //         child: Text(
    //           "Login",
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(20.0)),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _socialButtons() {
    return SizedBox(
      child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.only(top: 15.0),
        // alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            SizedBox(height: 0),

            // SizedBox(height: 200),
            Container(
                width: MediaQuery.of(context).size.width,
                child: FacebookSignInButton(
                  onPressed: _facebookLogin,
                  borderRadius: 20,
                  centered: true,
                  text: ' Login with Facebook ',
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: GoogleSignInButton(
                onPressed: _googleSignin,
                darkMode: false,
                borderRadius: 20,
                centered: true,
                text: ' Login with Google ',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _facebookButton() {
    return SizedBox(
      child: Container(
        // color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.only(top: 8.0),
        child: RaisedButton(
          padding: EdgeInsets.only(top: 3, bottom: 3, left: 6),
          elevation: 3,
          color: Theme.of(context).primaryColor,
          onPressed: _facebookLogin,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 35.0,
                height: 35.0,
                decoration: new BoxDecoration(
                  // color: Colors.black38,
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    image: AssetImage('assets/images/facebook_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8 - 30,
                // color: Colors.red,
                child: Center(
                  child: Text(
                    'Login with Facebook',
                    style: TextStyle(
                      // fontSize: 20,
                      // fontWeight: FontWeight.w700,
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

  Widget _googleButton() {
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.only(top: 8.0),
        child: RaisedButton(
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 6),
          elevation: 3,
          color: Colors.white,
          onPressed: _googleSignin,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 25.0,
                height: 25.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    image: AssetImage('assets/images/google-g-logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8 - 30,
                // color: Colors.red,
                child: Center(
                  child: Text(
                    'Login with Google',
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
