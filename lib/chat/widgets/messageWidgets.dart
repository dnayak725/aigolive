import 'package:aigolive/chat/models/chatModel.dart';
import 'package:aigolive/chat/models/notificationModel.dart';
import 'package:aigolive/chat/providers/chatProvider.dart';
import 'package:aigolive/chat/screens/chatBoxScreen.dart';
import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidgets extends StatelessWidget {
  final String sellerId;
  final String storeName;
  final String sellerAvatar;

  MessageWidgets(this.sellerId, this.storeName, this.sellerAvatar);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      List<MessageModel> messageList =
          chatProvider.messagesBySellerId(sellerId);
      // List<ChatModel> sellerChatTemp = chatProvider.messagesBySellerId(sellerId);
      // messageList.reversed;
      messageList.sort((a, b) {
        var adate = a.chatId; //before -> var adate = a.expiry;
        var bdate = b.chatId; //before -> var bdate = b.expiry;
        return bdate.compareTo(
            adate); //to get the order other way just switch `adate & bdate`
      });
      return messageList.isEmpty
          ? Center(child: Text('0 result'))
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: messageList.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (ctx, index) => Container(
                    // color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
                    // margin: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        index < messageList.length - 1 &&
                                messageList[index].time ==
                                    messageList[index + 1].time
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(messageList[index].time),
                              ),
                        messageList[index].sender == 1
                            ? Row(
                                //code for buyer message
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 115,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: Text(
                                      messageList[index].message,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                //code for seller message
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  index < messageList.length-1 &&
                                          messageList[index].sender ==
                                              messageList[index + 1].sender
                                      ? Container(
                                          width: 44,
                                        )
                                      : _getSellerProfile(sellerAvatar),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 115,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: Text(
                                      messageList[index].message,
                                      // textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    )),
              ));
    });
  }

  _getSellerProfile(String sellerAvatar) {
    return Container(
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
        width: 30.0,
        height: 30.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            image: NetworkImage(sellerAvatar),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
