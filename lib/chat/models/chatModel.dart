
class ChatModel {
  String sellerId;
  String storeName;
  String sellerAvatar;
  int chatId;
  String lastMessage;
  String time;
  List<MessageModel> messages;

  ChatModel(this.sellerId, this.storeName, this.sellerAvatar, this.chatId, this.lastMessage,this.time,this.messages);

}

class MessageModel {
  int chatId;
  // int sellerID;
  // int customerID;
  String message;
  String time;
  int sender; //1 for customer and 2 for seller
  MessageModel(this.chatId,this.message, this.time, this.sender);
}
