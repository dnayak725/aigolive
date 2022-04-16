import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/account-setting/screens/myAddressScreen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/providers/userLoginStatusProvider.dart';
import 'package:aigolive/pre-login/components/app_bar_pop_button.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_screen.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors().lightGrey,
      appBar: AppBar(
        leading: AppBarPopButton(),
        title: Text('Account Settings'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [MyColors().blueDark, MyColors().blueLight],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Account',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('My Profile'),
                          Icon(
                            Icons.chevron_right_sharp,
                            color: MyColors().iconColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAddressScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('My Addresses'),
                          Icon(
                            Icons.chevron_right_sharp,
                            color: MyColors().iconColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Divider(
                  //   height: 1,
                  // ),
                  // Container(
                  //   child: FlatButton(
                  //     onPressed: () {},
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text('Payment Method'),
                  //         Icon(
                  //           Icons.chevron_right_sharp,
                  //           color: MyColors().iconColor,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Notification Setting'),
                          Icon(
                            Icons.chevron_right_sharp,
                            color: MyColors().iconColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: _getLogoutButton(),
      ),
    );
  }

  Widget _getLogoutButton() {
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
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            logout();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => LoginScreen()),
            // );
          },
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Provider.of<UserLoginStatusProvider>(context, listen: false)
        .setLoginStatus("unknown");
    Provider.of<UserLoginStatusProvider>(context, listen: false)
        .setUserID(sharedPreferences.getString("0"));
    Provider.of<UserProfileProvider>(context, listen: false).resetData();
  }
}
