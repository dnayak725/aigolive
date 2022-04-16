import 'package:aigolive/chat/models/chatModel.dart';
import 'package:aigolive/chat/models/notificationModel.dart';
import 'package:aigolive/chat/providers/chatProvider.dart';
import 'package:aigolive/chat/screens/chatBoxScreen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      // List<ChatModel> chatList = chatProvider.chatList;
      List<ChatModel> chatList = chatProvider.chatList;
      chatList.sort((a, b) {
        var adate = a.chatId; //before -> var adate = a.expiry;
        var bdate = b.chatId; //before -> var bdate = b.expiry;
        return bdate.compareTo(
            adate); //to get the order other way just switch `adate & bdate`
      });
      return chatList.isEmpty
          ? Center(child: Text('0 result'))
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  chatList.length,
                  (index) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => ChatBoxScreen(
                                  chatList[index].sellerId,
                                  chatList[index].storeName,
                                  chatList[index].sellerAvatar)));
                        },
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 6),
                          // margin: EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 8,
                                ),
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: NetworkImage(
                                          chatList[index].sellerAvatar),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 115,
                                padding: EdgeInsets.only(top: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      chatList[index].storeName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          // fontSize: 18,
                                          color: Colors.grey[700]),
                                    ),
                                    Text(
                                      chatList[index].lastMessage,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Text(chatList[index].time),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey[300],
                        height: 1,
                      ),
                    ],
                  ),
                ).toList(),
              ),
            );
    });
  }
}
