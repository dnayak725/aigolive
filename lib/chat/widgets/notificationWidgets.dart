import 'package:aigolive/account-setting/orders/models/purchases_model.dart';
import 'package:aigolive/account-setting/orders/providers/purchases.dart';
import 'package:aigolive/account-setting/orders/screens/order_details_screen.dart';
import 'package:aigolive/chat/models/notificationModel.dart';
import 'package:aigolive/chat/providers/notificationProvider.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/models/streamModel.dart';
import 'package:aigolive/live-steaming/models/SessionDetailsProductsModel.dart';
import 'package:aigolive/live-steaming/providers/SessionDetailsProductsProvider.dart';
import 'package:aigolive/live-steaming/screens/live_stream_screen.dart';
import 'package:aigolive/stores/screens/productDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
      List<NotificationModel> notificationList =
          notificationProvider.notificationList;
      return notificationList.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(child: Text('0 result')),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  notificationList.length,
                  (index) => Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15),
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8, top: 5),
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
                                    image: NetworkImage(
                                        notificationList[index].icon),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 115,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    notificationList[index].notificationHeader,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(notificationList[index].message,
                                      textAlign: TextAlign.justify),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _viewOrderButton(
                                          notificationList[index], context),
                                      Text(notificationList[index].time),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  _viewOrderButton(NotificationModel notification, BuildContext context) {
    switch (notification.notificationType) {
      case "1":
        return GestureDetector(
          onTap: () {
            List<PurchasesModel> orderList =
                Provider.of<Purchases>(context, listen: false).userPurchaseList;
            int orderIndex = orderList.indexWhere(
                (element) => element.orderId == notification.metaData);
            print(orderList[orderIndex].orderId);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OrderDetailsScreen(orderList[orderIndex].orderId),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: new BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Colors.blueAccent,
                width: 1.5,
              ),
            ),
            child: Text(
              'View Order',
              style: TextStyle(color: MyColors().whiteSection),
            ),
          ),
        );
        break;
      case "2":
        return GestureDetector(
          onTap: () async {
            await Provider.of<SessionDetailsProductsProvider>(context,
                    listen: false)
                .fetchData(notification.metaData);
            SessionDetailsProductsModel sessionDetails =
                Provider.of<SessionDetailsProductsProvider>(context,
                        listen: false)
                    .sessionDetails;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LiveStreamScreen(
                  StreamModel(
                    id: notification.metaData,
                    sessionId: sessionDetails.sessionId,
                    sellerId: sessionDetails.sellerId,
                    img: "ffgcf",
                    shopName: "",
                    status: "ffgcf",
                    logo: "",
                    category: "ffgcf",
                    title: sessionDetails.sessionName,
                    watching: "34k",
                    date: "ffgcf",
                    time: "ffgcf",
                    timePassed: "ffgcf",
                    videoLink: sessionDetails.videoLink,
                  ),
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: new BoxDecoration(
              color: MyColors().orderCancelButtonColor,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: MyColors().orderCancelButtonColor,
                width: 1.5,
              ),
            ),
            child: Text(
              'Watch Now',
              style: TextStyle(color: MyColors().whiteSection),
            ),
          ),
        );
        break;
      case "3":
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  notification.metaData,
                  null,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: new BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Colors.blueAccent,
                width: 1.5,
              ),
            ),
            child: Text(
              'Product Details',
              style: TextStyle(color: MyColors().whiteSection),
            ),
          ),
        );
        break;
      default:
        return SizedBox();
    }
  }
}
