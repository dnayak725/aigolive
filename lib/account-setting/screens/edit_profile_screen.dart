import 'dart:convert';
import 'dart:io';
import 'package:aigolive/account-setting/models/categoryInterestModel.dart';
import 'package:http_parser/http_parser.dart';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'change_password_screen.dart';
import 'package:mime/mime.dart';
import 'package:flutter/services.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isEditMobile = false;
  bool _isEditName = false;
  bool _isEditEmail = false;
  bool _isEditGender = false;
  bool _isEditCategories = false;
  bool _isEnterPassword = false;
  String _dob;
  int _userId = 0;
  final TextEditingController _fullNameController = new TextEditingController();
  final TextEditingController _mobileNumberController =
      new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  String _genderValue = "Male";
  int _selectedGender = 1;

  syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      _userId = int.parse(sharedPreferences.getString('user_id'));
      Provider.of<UserProfileProvider>(context, listen: false)
          .fetchData(sharedPreferences.getString("user_id"));
      _mobileNumberController.text =
          Provider.of<UserProfileProvider>(context, listen: false).mobileNumber;
      _fullNameController.text =
          Provider.of<UserProfileProvider>(context, listen: false).fullName;
      Provider.of<UserProfileProvider>(context, listen: false)
          .getAllCategories();
    }
  }

  @override
  void initState() {
    super.initState();
    syncData();
  }

  @override
  Widget build(BuildContext context) {
    var userProfile = Provider.of<UserProfileProvider>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: MyColors().lightGrey,
      appBar: AppBar(
        leading: AccountBarPopButton(),
        title: Text('Edit Profile'),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                  margin: EdgeInsets.only(bottom: 15),
                  child: Consumer<UserProfileProvider>(
                    builder: (context, profile, child) {
                      return Row(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: new BoxDecoration(
                              // color: Colors.red,
                              shape: BoxShape.circle,
                              // border: Border.all(
                              //   color: Colors.red,
                              //   width: 1,
                              // ),
                              image: new DecorationImage(
                                image: new NetworkImage(profile.photoUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  getImage();
                                },
                                textColor: Colors.white,
                                color: MyColors().toShipButtonColor,
                                child: const Text(
                                  'Change Avatar',
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'File size: maximum 1 MB',
                              ),
                              Text(
                                'File extension: .JPEG, .PNG',
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _isEditName = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Full Name'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    userProfile.fullName,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: MyColors().iconColor,
                                  ),
                                ],
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
                                    builder: (context) =>
                                        ChangePasswordScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Change Password'),
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
                            setState(() {
                              _isEditMobile = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Mobile'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    userProfile.mobileNumber,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: MyColors().iconColor,
                                  ),
                                ],
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
                            // setState(() {
                            //   _isEditEmail = true;
                            // });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Email'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    userProfile.email,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: MyColors().iconColor,
                                  ),
                                ],
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
                          onPressed: _presentDatePicker,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date of Birth'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    userProfile.dob,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: MyColors().iconColor,
                                  ),
                                ],
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
                            setState(() {
                              _isEditGender = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Gender'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    userProfile.gender,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    color: MyColors().iconColor,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Interests',
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
                            setState(() {
                              _isEditCategories = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Category & Interests'),
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
          _isEditMobile ? _editMobileWidget(context) : Container(),
          _isEditName ? _editNameWidget(context) : Container(),
          _isEditEmail ? _editEmailWidget(context) : Container(),
          _isEditGender ? _editGenderWidget(context) : Container(),
          _isEditCategories ? _editCategoriesWidget(context) : Container(),
          _isEnterPassword ? _enterPassword(context) : Container(),
        ],
      ),
    );
  }

  Uri apiUrl =
      Uri.parse(AppConfig().apiLink + "Customer/PostBuyersProfilePhoto");
  Future<void> getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // setState(() {
    //   _image = image;
    //   print('Image Path $_image');
    // });
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('PUT', apiUrl);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('Photo', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension

    imageUploadRequest.fields['Photo'] = mimeTypeData[1];

    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['ID'] = "18";
    imageUploadRequest.headers["Content-Type"] = "multipart/form-data";
    imageUploadRequest.headers["ApiKey"] =
        "cDa98K42-79eb-4B31-9I32-4b060Ff11557";
    // imageUploadRequest.fields['email'] = _email;
    // imageUploadRequest.fields['contact_no'] = _contact;

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "success") {
          syncData();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _editMobileWidget(BuildContext context) {
    return SingleChildScrollView(
        child: GestureDetector(
      onTap: () {
        setState(() {
          _isEditMobile = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.only(bottom: 40),
        color: Colors.black38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    // height: 220,
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.symmetric(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mobile Number',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _mobileNumberController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            // icon: Icon(Icons.tag_faces,
                            //     color: Theme.of(context).primaryColor),
                            labelText: "New mobile number",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyle(color: Colors.black38),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel,
                                  color: Color.fromARGB(255, 255, 153, 85),
                                  size: 15),
                              onPressed: () {
                                _mobileNumberController.text = "";
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.0,
                          // padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(top: 40.0, bottom: 20),
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
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: const StadiumBorder(),
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Provider.of<UserProfileProvider>(context,
                                        listen: false)
                                    .updateMobileNumber(
                                        _mobileNumberController.text);
                                setState(() {
                                  _isEditMobile = false;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 5,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    // tooltip: 'Increase volume by 10',
                    onPressed: () {
                      setState(() {
                        _isEditMobile = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  _editNameWidget(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isEditName = false;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.only(bottom: 40),
          color: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.white,
                      // height: 220,
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 80),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            // margin: EdgeInsets.symmetric(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Full Name',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _fullNameController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              // icon: Icon(Icons.tag_faces,
                              //     color: Theme.of(context).primaryColor),
                              labelText: "First and last name",
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              hintStyle: TextStyle(color: Colors.black38),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.cancel,
                                    color: Color.fromARGB(255, 255, 153, 85),
                                    size: 15),
                                onPressed: () {
                                  _fullNameController.text = "";
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40.0,
                            // padding: EdgeInsets.symmetric(horizontal: 15.0),
                            margin: EdgeInsets.only(top: 40.0, bottom: 20),
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
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: const StadiumBorder(),
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_fullNameController.text == "") {
                                    //show error dialog box
                                  } else {
                                    var names =
                                        _fullNameController.text.split(" ");
                                    var fName = "";
                                    var lName = "";
                                    for (int i = 0; i < names.length; i++) {
                                      if (i == 0) {
                                        fName = names[i];
                                      } else {
                                        lName = names[i] + " ";
                                      }
                                    }
                                    Provider.of<UserProfileProvider>(context,
                                            listen: false)
                                        .updateName(fName, lName);
                                    setState(() {
                                      _isEditName = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 5,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      // tooltip: 'Increase volume by 10',
                      onPressed: () {
                        setState(() {
                          _isEditName = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _editEmailWidget(BuildContext context) {
    return SingleChildScrollView(
        child: GestureDetector(
      onTap: () {
        setState(() {
          _isEditEmail = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.only(bottom: 40),
        color: Colors.black38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                    // height: 220,
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.symmetric(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            // icon: Icon(Icons.tag_faces,
                            //     color: Theme.of(context).primaryColor),
                            labelText: "New email address",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyle(color: Colors.black38),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel,
                                  color: Color.fromARGB(255, 255, 153, 85),
                                  size: 15),
                              onPressed: () {
                                _emailController.text = "";
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.0,
                          // padding: EdgeInsets.symmetric(horizontal: 15.0),
                          margin: EdgeInsets.only(top: 40.0, bottom: 20),
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
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: const StadiumBorder(),
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (_emailController.text == "") {
                                  _showAlertDialog("Alert",
                                      "Email must not be blank.", "Try Again");
                                } else {
                                  setState(() {
                                    _isEnterPassword = true;
                                    _isEditEmail = false;
                                  });
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 5,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    // tooltip: 'Increase volume by 10',
                    onPressed: () {
                      setState(() {
                        _isEditEmail = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  _enterPassword(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isEnterPassword = false;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.only(bottom: 40),
          color: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.white,
                      // height: 220,
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 80),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            // margin: EdgeInsets.symmetric(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Password',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              // icon: Icon(Icons.tag_faces,
                              //     color: Theme.of(context).primaryColor),
                              labelText: "Current password",
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              hintStyle: TextStyle(color: Colors.black38),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.cancel,
                                    color: Color.fromARGB(255, 255, 153, 85),
                                    size: 15),
                                onPressed: () {
                                  _passwordController.text = "";
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40.0,
                            // padding: EdgeInsets.symmetric(horizontal: 15.0),
                            margin: EdgeInsets.only(top: 40.0, bottom: 20),
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
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: const StadiumBorder(),
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: _changeEmail,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 5,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      // tooltip: 'Increase volume by 10',
                      onPressed: () {
                        setState(() {
                          _isEnterPassword = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _editGenderWidget(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          if (_genderValue == 'Male') {
            _selectedGender = 1;
          } else if (_genderValue == 'Female') {
            _selectedGender = 2;
          } else {
            _selectedGender = 3;
          }
          setState(() {
            _isEditGender = false;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.only(bottom: 40),
          color: Colors.black38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.white,
                      // height: 220,
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 80),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () {
                                // Navigator.of(context).pop();
                                setState(() {
                                  _selectedGender = 1;
                                  // _isEditGender = false;
                                });
                              },
                              child: Container(
                                child: Text(
                                  'Male',
                                  style: _selectedGender == 1
                                      ? TextStyle(fontWeight: FontWeight.bold)
                                      : TextStyle(),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = 2;
                                // _isEditGender = false;
                              });
                            },
                            child: Text(
                              'Female',
                              style: _selectedGender == 2
                                  ? TextStyle(fontWeight: FontWeight.bold)
                                  : TextStyle(),
                            ),
                          ),
                          Divider(),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = 3;
                              });
                            },
                            child: Text(
                              'Rather Not Say',
                              style: _selectedGender == 3
                                  ? TextStyle(fontWeight: FontWeight.bold)
                                  : TextStyle(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 5,
                    child: FlatButton(
                      // tooltip: 'Increase volume by 10',
                      child: Text('Done'),
                      // tooltip: 'Increase volume by 10',
                      onPressed: () async {
                        if (_selectedGender == 1) {
                          _genderValue = 'M';
                        } else if (_selectedGender == 2) {
                          _genderValue = 'F';
                        } else {
                          _genderValue = 'NA';
                        }
                        Provider.of<UserProfileProvider>(context, listen: false)
                            .updateGender(_genderValue);
                        // if (res) {
                        //   print("success");
                        // } else {
                        //   print("Failed");
                        // }
                        setState(() {
                          _isEditGender = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _presentDatePicker() {
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
        _dob = DateFormat('y-M-d').format(pickedDate);
        Provider.of<UserProfileProvider>(context, listen: false)
            .updateDOB(_dob);
        // print(_dob);
      });
    });
    // print('...');
  }

  _editCategoriesWidget(BuildContext context) {
    return Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, child) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isEditCategories = false;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 40),
                color: Colors.black38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: Colors.white,
                            // height: 220,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 80),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlatButton(
                                        onPressed: () {
                                          userProfileProvider
                                              .selectAllCategories();
                                        },
                                        child: Text(
                                          'Select all',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          userProfileProvider
                                              .deselectAllCategories();
                                        },
                                        child: Text(
                                          'Clear',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: userProfileProvider.allCategories
                                      .map((item) {
                                    return Row(
                                      children: [
                                        new Checkbox(
                                          // title: Text(key),
                                          activeColor: MyColors().iconColor,
                                          value: item.selected,
                                          onChanged: (bool value) {
                                            // item.selected = value;
                                            userProfileProvider
                                                .changeSelectStatus(item.value);
                                          },
                                        ),
                                        Text(item.text),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 5,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            // tooltip: 'Increase volume by 10',
                            onPressed: () {
                              setState(() {
                                _isEditCategories = false;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70.0,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              // margin: EdgeInsets.only(top: 40.0, bottom: 20),

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
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
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Provider.of<UserProfileProvider>(context, listen: false)
                        .updateCategories(context);
                  },
                ),
              ),
            ),
          )
        ],
      );
    });
//comments
    // return Stack(
    //   children: [
    //     SingleChildScrollView(
    //       child: GestureDetector(
    //         onTap: () {
    //           setState(() {
    //             _isEditCategories = false;
    //           });
    //         },
    //         child: Container(
    //           width: MediaQuery.of(context).size.width,
    //           // height: MediaQuery.of(context).size.height,
    //           padding: EdgeInsets.only(top: 40),
    //           color: Colors.black38,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               Stack(
    //                 children: [
    //                   GestureDetector(
    //                     onTap: () {},
    //                     child: Container(
    //                       color: Colors.white,
    //                       // height: 220,
    //                       padding: EdgeInsets.only(
    //                           left: 10, right: 10, top: 10, bottom: 80),
    //                       child: Column(
    //                         mainAxisSize: MainAxisSize.max,
    //                         // crossAxisAlignment: CrossAxisAlignment.end,
    //                         // mainAxisAlignment: MainAxisAlignment.end,
    //                         children: <Widget>[
    //                           Container(
    //                             margin: EdgeInsets.only(top: 30),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 FlatButton(
    //                                   onPressed: () {
    //                                     values.forEach((item) {
    //                                       setState(() {
    //                                         item.selected = true;
    //                                       });
    //                                     });
    //                                   },
    //                                   child: Text(
    //                                     'Select all',
    //                                     style: TextStyle(
    //                                         fontSize: 20,
    //                                         fontWeight: FontWeight.bold),
    //                                   ),
    //                                 ),
    //                                 FlatButton(
    //                                   onPressed: () {
    //                                     values.forEach((item) {
    //                                       setState(() {
    //                                         item.selected = false;
    //                                       });
    //                                     });
    //                                   },
    //                                   child: Text(
    //                                     'Clear',
    //                                     style: TextStyle(
    //                                         fontSize: 20,
    //                                         fontWeight: FontWeight.bold),
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 20,
    //                           ),
    //                           Column(
    //                             children: values.map((item) {
    //                               return Row(
    //                                 children: [
    //                                   new Checkbox(
    //                                     // title: Text(key),
    //                                     activeColor: MyColors().iconColor,
    //                                     value: item.selected,
    //                                     onChanged: (bool value) {
    //                                       setState(() {
    //                                         item.selected = value;
    //                                       });
    //                                     },
    //                                   ),
    //                                   Text(item.text),
    //                                 ],
    //                               );
    //                             }).toList(),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Positioned(
    //                     top: 0,
    //                     right: 5,
    //                     child: IconButton(
    //                       icon: Icon(Icons.close),
    //                       // tooltip: 'Increase volume by 10',
    //                       onPressed: () {
    //                         setState(() {
    //                           _isEditCategories = false;
    //                         });
    //                       },
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       bottom: 0,
    //       child: Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: 70.0,
    //         padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
    //         // margin: EdgeInsets.only(top: 40.0, bottom: 20),

    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           border: Border(
    //             top: BorderSide(
    //               color: Colors.grey,
    //               width: 1,
    //             ),
    //           ),
    //         ),
    //         child: Container(
    //           decoration: ShapeDecoration(
    //             shape: const StadiumBorder(),
    //             gradient: LinearGradient(
    //               colors: [
    //                 MyColors().blueDark,
    //                 MyColors().blueLight,
    //               ],
    //             ),
    //           ),
    //           child: MaterialButton(
    //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //             shape: const StadiumBorder(),
    //             child: Text(
    //               'Save',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () {},
    //           ),
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }

  _changeEmail() async {
    if (_passwordController.text == "") {
      _showAlertDialog("Alert", "Password must not be blank.", "Try Again");
    } else {
      final response = await http.post(
        ApiLinks().updateEmailApi,
        headers: {
          "Content-Type": "application/json",
          "ApiKey": AppConfig().apiKey,
        },
        body: jsonEncode({
          "ID": _userId,
          "PASSWORD": _passwordController.text,
          "email": _emailController.text
        }),
      );

      if (response.statusCode == 200) {
        _showAlertDialog("Success!", "Your email ID has been changed.", "OK");
      } else
        _showAlertDialog(
            "Failed!", "Failed to update your new email.", "Try Again");
      syncData();
    }

    setState(() {
      _isEnterPassword = false;
    });
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
}
