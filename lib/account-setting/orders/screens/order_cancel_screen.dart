import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:aigolive/account-setting/orders/models/purchases_model.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/config/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderCancelScreen extends StatefulWidget {
  final OItemModel orderDetails;
  final String paidOn;

  const OrderCancelScreen(this.orderDetails, this.paidOn);

  @override
  _OrderCancelScreenState createState() => _OrderCancelScreenState();
}

class _OrderCancelScreenState extends State<OrderCancelScreen> {
  List<String> _reasonList = [
    "Purchased item by mistake or changed mind",
    "Buy it from other sellers",
    "Shipping time was too long",
    "Other Reason"
  ];
  int _selectedReason = 0;
  bool _isOpenedOptions = false;
  final TextEditingController _reasonController = new TextEditingController();
  final TextEditingController _commentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cancellation Request'),
          centerTitle: true,
          leading: AccountBarPopButton(),
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
              child: Container(
                child: Column(
                  children: [
                    Container(
                      // color: Colors.grey,
                      child: ListTile(
                        title: Text(
                          "Order Number #" +
                              widget.orderDetails.orderNum.toString() +
                              "  ",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          "Paid on " + widget.paidOn,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      // margin: EdgeInsets.only(top: 3.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                  image: (widget.orderDetails.image == null ||
                                          widget.orderDetails.image == "")
                                      ? AssetImage('assets/images/noimage.png')
                                      : NetworkImage(widget.orderDetails.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.orderDetails.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "x " + widget.orderDetails.quantity,
                                ),
                              ],
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
                        readOnly: true,
                        controller: _reasonController,
                        cursorColor: Colors.white,
                        // obscureText: _cPasswordVisible,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Cancellation Reason",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          hintStyle: TextStyle(color: Colors.black38),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              // color: Color.fromARGB(255, 255, 153, 85),
                            ),
                            onPressed: () {
                              setState(() {
                                _isOpenedOptions = true;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    _selectedReason == 3
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            margin: EdgeInsets.only(top: 15.0),
                            child: Text('Additional Comments (Optional)'),
                          )
                        : Container(),
                    _selectedReason == 3
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            margin: EdgeInsets.only(top: 15.0),
                            child: TextFormField(
                              maxLines: 3,
                              controller: _commentController,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white70)),
                                hintStyle: TextStyle(color: Colors.black38),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            _isOpenedOptions ? _reasonOptionsWidget(context) : Container(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: _getSubmitButton(),
        ));
  }

  Widget _getSubmitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: _isOpenedOptions ? 0 : 40.0,
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
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _submit();
          },
        ),
      ),
    );
  }

  _submit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    String reason = _reasonController.text;
    if (_reasonController.text == "Other Reason") {
      reason = reason + " - " + _commentController.text;
    } else {
      reason = _reasonController.text;
    }
    if (reason == "" || reason == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert!!"),
            content: Text("Please select a reason."),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    } else {
      final response = await http.put(
        ApiLinks().cancelOrderApi,
        headers: {
          "Content-Type": "application/json",
          "ApiKey": AppConfig().apiKey,
        },
        body: jsonEncode({
          "CustID": int.parse(userId),
          "ID": int.parse(widget.orderDetails.orderItemId),
          "StatusReason": reason
        }),
      );
      switch (response.statusCode) {
        case 200:
          var results = json.decode(response.body);
          if (results['status'] == "Success") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Alert!!"),
                  content: Text("Order #" +
                      widget.orderDetails.orderNum +
                      " has beeen cancelled."),
                  actions: [
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Alert!!"),
                  content: Text("Something went wrong. Please try again."),
                  actions: [
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
          }
          print("LTPL: PurchaseCancelOrder api data fetched");
          break;
        default:
          print("LTPL: PurchaseCancelOrder api error");
          Navigator.pop(context);
          break;
      }
    }
  }

  _reasonOptionsWidget(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isOpenedOptions = false;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.only(bottom: 60),
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
                        // mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  _selectedReason = 0;
                                  _reasonController.text = _reasonList[0];
                                  _isOpenedOptions = false;
                                });
                              },
                              child: Container(
                                child: Text(
                                  _reasonList[0],
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _selectedReason = 1;
                                _reasonController.text = _reasonList[1];
                                _isOpenedOptions = false;
                              });
                            },
                            child: Text(
                              _reasonList[1],
                            ),
                          ),
                          Divider(),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _selectedReason = 2;
                                _reasonController.text = _reasonList[2];
                                _isOpenedOptions = false;
                              });
                            },
                            child: Text(
                              _reasonList[2],
                            ),
                          ),
                          Divider(),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _selectedReason = 3;
                                _reasonController.text = _reasonList[3];
                                _isOpenedOptions = false;
                              });
                            },
                            child: Text(
                              _reasonList[3],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   right: 5,
                  //   child: FlatButton(
                  //     // tooltip: 'Increase volume by 10',
                  //     child: Text('Done'),
                  //     // tooltip: 'Increase volume by 10',
                  //     onPressed: () {
                  //       setState(() {
                  //         _isOpenedOptions = false;
                  //       });
                  //     },
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
