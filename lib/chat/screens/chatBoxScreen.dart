import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:aigolive/chat/providers/chatProvider.dart';
import 'package:aigolive/chat/widgets/messageWidgets.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/config/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatBoxScreen extends StatefulWidget {
  final String sellerId;
  final String storeName;
  final String sellerAvatar;
  ChatBoxScreen(this.sellerId, this.storeName, this.sellerAvatar);

  @override
  _ChatBoxScreenState createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {
  final TextEditingController messageInoutController =
      new TextEditingController();

  fetchIsLogin() async {
    // print("LTPL: getting value from  sp");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('status') &&
        sharedPreferences.getString("status") == "success") {
      var id = sharedPreferences.getString("user_id");
      var status = sharedPreferences.getString("status");
      // print("LTPL: user id = " + sharedPreferences.getString("user_id"));
      Provider.of<ChatProvider>(context, listen: false)
          .fetchPrivateMessageHistory(widget.sellerId, id);
      // Provider.of<UserLoginStatusProvider>(context, listen: false)
      //     .setUserID(id);
      // Provider.of<UserProfileProvider>(context, listen: false).fetchData(id);
    }
    // return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: Text(widget.storeName),
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
      body: Container(
        // height: MediaQuery.of(context).viewInsets.bottom,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  // height: 600,
                  child: MessageWidgets(
                      widget.sellerId, widget.storeName, widget.sellerAvatar),
                ),
                Container(
                  height: 80,
                )
              ],
            ),
            Positioned(
              bottom: 0,
              child: _sendMessageWidget(context),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   child: Padding(
      //     padding: EdgeInsets.only(bottom: 2),
      //     child: _sendMessageWidget(context),
      //   ),
      // ),
    );
  }

  _sendMessageWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70.0,
      padding: EdgeInsets.only(left: 15.0, right: 15, bottom: 5, top: 5),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 1))),
      child: Container(
        padding: EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 3,
                controller: messageInoutController,
                // cursorColor: Colors.white,
                // obscureText: _passwordVisible,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  // icon: Icon(Icons.lock,
                  //     color: Theme.of(context).primaryColor),
                  // labelText: "Password *",
                  hintText: 'Type your message..',
                  hintStyle: TextStyle(color: Colors.black38),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (messageInoutController.text != "") {
                  var msg= messageInoutController.text;
                  messageInoutController.text = "";
                  await Provider.of<ChatProvider>(context, listen: false)
                      .sendMassage(
                          widget.sellerId, msg);
                  
                }
              },
              child: Container(
                height: 90,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: new BoxDecoration(
                  color: MyColors().toShipButtonColor,
                  // borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: MyColors().toShipButtonColor,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.subdirectory_arrow_left,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
