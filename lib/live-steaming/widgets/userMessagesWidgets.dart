import 'package:aigolive/live-steaming/providers/userMessageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserMessageWidgets extends StatefulWidget {
  @override
  _UserMessageWidgetsState createState() => _UserMessageWidgetsState();
}

class _UserMessageWidgetsState extends State<UserMessageWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? EdgeInsets.symmetric(horizontal: 15)
          : EdgeInsets.all(0),
      height: 50,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<UserMessageProvider>(
              builder: (context, uMsg, child) => ListView.builder(
                itemCount: uMsg.userMessage.length,
                shrinkWrap: true,
                reverse: true,
                physics: ScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return Text(
                    uMsg.userMessage[index].fullName +
                        ' : ' +
                        uMsg.userMessage[index].message,
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // child: ListView.builder(
      //   itemCount: widget._messages.length,
      //   // controller: ScrollController()
      //   //   ..animateTo(
      //   //     0.0,
      //   //     curve: Curves.easeOut,
      //   //     duration: const Duration(milliseconds: 300),
      //   //   ),
      //   reverse: true,
      //   shrinkWrap: true,
      //   itemBuilder: (ctx, index) {
      //     return Text(
      //       widget._messages[index].userName +
      //           ' : ' +
      //           widget._messages[index].message,
      //       style: TextStyle(color: Colors.white),
      //     );
      //   },
      // ),
    );
  }
}
