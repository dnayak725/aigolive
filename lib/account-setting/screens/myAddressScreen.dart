import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/account-setting/widgets/addressesWidgets.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/pre-login/components/app_bar_pop_button.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddressScreen extends StatefulWidget {
  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  bool _isEnableAddNewForm = false;
  bool _isLoading = false;
  bool _isDefault = false;
  int _userId = 0;

  syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      _userId = int.parse(sharedPreferences.getString('user_id'));
      Provider.of<UserProfileProvider>(context, listen: false)
          .fetchData(sharedPreferences.getString("user_id"));
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
      backgroundColor: MyColors().lightGrey,
      appBar: AppBar(
        leading: AppBarPopButton(),
        title: Text('My Addresses'),
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
                // Container(
                //   color: Colors.white,
                //   width: MediaQuery.of(context).size.width,
                //   padding:
                //       EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                //   margin: EdgeInsets.only(bottom: 10),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Name',
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           Container(
                //             child: Text('Default'),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 5,
                //       ),
                //       Text(
                //         '+65 xxxxxxxxx',
                //       ),
                //       Text(
                //         'Address -Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet',
                //       ),
                //     ],
                //   ),
                // ),
                AddressesWidgets(),
                _getAddNewWidgets(context),
              ],
            ),
          ),
          _isEnableAddNewForm ? _getFormWidgets() : Container(),
        ],
      ),
    );
  }

  final TextEditingController _fullNameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _addressController = new TextEditingController();
  final TextEditingController _unitNumberController =
      new TextEditingController();
  final TextEditingController _postalNumberController =
      new TextEditingController();
  _getFormWidgets() {
    return _isLoading
        ? Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()))
        : SingleChildScrollView(
            child: GestureDetector(
            onTap: () {
              setState(() {
                _isEnableAddNewForm = false;
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
                                      'New Address',
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
                                keyboardType: TextInputType.name,
                                controller: _fullNameController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: "Jerald Tan",
                                  // icon: Icon(Icons.tag_faces,
                                  //     color: Theme.of(context).primaryColor),
                                  labelText: "Full Name",
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  hintStyle: TextStyle(color: Colors.black38),
                                  // suffixIcon: IconButton(
                                  //   icon: Icon(Icons.cancel,
                                  //       color: Color.fromARGB(255, 255, 153, 85),
                                  //       size: 15),
                                  //   onPressed: () {
                                  //     _fullNameController.text = "";
                                  //   },
                                  // ),
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _phoneController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: "Set Phone Number",
                                  // icon: Icon(Icons.tag_faces,
                                  //     color: Theme.of(context).primaryColor),
                                  labelText: "Phone Number",
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  hintStyle: TextStyle(color: Colors.black38),
                                  // suffixIcon: IconButton(
                                  //   icon: Icon(Icons.cancel,
                                  //       color: Color.fromARGB(255, 255, 153, 85),
                                  //       size: 15),
                                  //   onPressed: () {
                                  //     _phoneController.text = "";
                                  //   },
                                  // ),
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _addressController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText:
                                      "Block Number, House Number, Building, Street Name",
                                  // icon: Icon(Icons.tag_faces,
                                  //     color: Theme.of(context).primaryColor),
                                  labelText: "Address",
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  hintStyle: TextStyle(color: Colors.black38),
                                  // suffixIcon: IconButton(
                                  //   icon: Icon(Icons.cancel,
                                  //       color: Color.fromARGB(255, 255, 153, 85),
                                  //       size: 15),
                                  //   onPressed: () {
                                  //     _addressController.text = "";
                                  //   },
                                  // ),
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _unitNumberController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: "Set Unit No. #",
                                  // icon: Icon(Icons.tag_faces,
                                  //     color: Theme.of(context).primaryColor),
                                  labelText: "Unit Number",
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  hintStyle: TextStyle(color: Colors.black38),
                                  // suffixIcon: IconButton(
                                  //   icon: Icon(Icons.cancel,
                                  //       color: Color.fromARGB(255, 255, 153, 85),
                                  //       size: 15),
                                  //   onPressed: () {
                                  //     _unitNumberController.text = "";
                                  //   },
                                  // ),
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _postalNumberController,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: "Set 6 digit Postal Code",
                                  // icon: Icon(Icons.tag_faces,
                                  //     color: Theme.of(context).primaryColor),
                                  labelText: "Postal Code",
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
                                  hintStyle: TextStyle(color: Colors.black38),
                                  // suffixIcon: IconButton(
                                  //   icon: Icon(Icons.cancel,
                                  //       color: Color.fromARGB(255, 255, 153, 85),
                                  //       size: 15),
                                  //   onPressed: () {
                                  //     _postalNumberController.text = "";
                                  //   },
                                  // ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Set as default address',
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Switch(
                                      activeTrackColor: Colors.lime[800],
                                      activeColor: Colors.white,
                                      value: _isDefault,
                                      onChanged: (value) {
                                        setState(() {
                                          _isDefault = value;
                                        });
                                      }),
                                ],
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
                                      _saveNewAddress();
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
                              _isEnableAddNewForm = false;
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

  _getAddNewWidgets(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add a new address',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.add),
              color: MyColors().iconColor,
              onPressed: () {
                setState(() {
                  _isEnableAddNewForm = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  _saveNewAddress() async {
    print(_fullNameController.text +
        "-" +
        _phoneController.text +
        "-" +
        _addressController.text);
    setState(() {
      _isLoading = true;
    });
    final response = await http.post(
      ApiLinks().addNewAddressApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({
        "CUST_ID": _userId,
        "NAME": _fullNameController.text,
        "PHONE": _phoneController.text.toString(),
        "ADDRESS": _addressController.text +
            ", Unit no.: " +
            _unitNumberController.text +
            ", Postal code: " +
            _postalNumberController.text
      }),
    );
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      Provider.of<UserProfileProvider>(context, listen: false)
          .fetchData(_userId.toString());
      setState(() {
        _isLoading = false;
        _isEnableAddNewForm = false;
      });
    } else {
      print(response.statusCode);
      setState(() {
        _isLoading = false;
        _isEnableAddNewForm = false;
      });
    }
  }
}
