import 'package:aigolive/chat/models/chatModel.dart';
import 'package:aigolive/config/config.dart';
import 'package:aigolive/live-steaming/widgets/sellerDetailsWidget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChatProvider with ChangeNotifier {
  String bId;
  List<ChatModel> chatList = [];

  int tempIndex = 10000;
  String chatListFetchingStatus = "fetching";

  fetchConversationsData(String userId) async {
    bId=userId;
    final response = await http.get(
      ApiLinks().getConversationListApi + userId,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          chatListFetchingStatus = results['status'];
          var data = results['data'];
          print(data);
          List<ChatModel> temp = [];
          data.forEach((item) {
            temp.add(ChatModel(
                item['sellerId'].toString(),
                item['shopName'].toString(),
                item['pic'].toString(),
                int.parse(item['lastMessageId'].toString()),
                item['lastMessage'],
                item['messageTime'], []));
          });
          if (temp.length > 0)
            chatList = temp;
          else
            chatList = [];
        }
        break;

      default:
        print("LTPL: GetOnAirStream api error");
        break;
    }
    notifyListeners();
  }

  fetchPrivateMessageHistory(String sellerId, String buyerId) async {
    final response = await http.get(
      ApiLinks().getPrivateMessageHistoryApi + buyerId + "/" + sellerId,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "success") {
          chatListFetchingStatus = results['status'];
          var data = results['data'];print(data);
          List<MessageModel> temp = [];
          data.forEach((item) {
            temp.add(MessageModel(
                int.parse(item['id'].toString()),
                item['message'].toString(),
                item['datetime'],
                int.parse(item['senderid'].toString())));
          });

          chatList.forEach((element) {
            if (element.sellerId.toString() == sellerId.toString()) {
              if (temp.length > 0) {
                element.messages = temp;
              } else
                element.messages = [];
            }
          });
        }
        print("LTPL: GetOnAirStream api data fetched");
        break;

      default:
        print("LTPL: GetOnAirStream api error");
        break;
    }
    notifyListeners();
  }

  List<MessageModel> messagesBySellerId(String sellerId) {
    List<MessageModel> temp = [];
    chatList.forEach((element) {
      if (element.sellerId.toString() == sellerId.toString()) {
        temp = element.messages;
      }
    });
    print(temp);
    return temp;
  }

  sendMassage(String sellerId, String message) async{
  final response = await http.post(
      ApiLinks().sendmessageToSellerApi,
      headers: {
        "Content-Type": "application/json",
        "ApiKey": AppConfig().apiKey,
      },
      body: jsonEncode({"custid": int.parse(bId), "sellerid": int.parse(sellerId),"message":message}),
    );
    switch (response.statusCode) {
      case 200:
        var results = json.decode(response.body);
        if (results['status'] == "Success") {
          var data = results['data'];print(data);
         await fetchPrivateMessageHistory(sellerId, bId);
         notifyListeners();
        }
        break;
      default: print(response.statusCode.toString());
    }
  }
}
