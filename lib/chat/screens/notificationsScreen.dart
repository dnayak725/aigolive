import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:aigolive/account-setting/orders/providers/purchases.dart';
import 'package:aigolive/account-setting/orders/widgets/all_purchases_widgets.dart';
import 'package:aigolive/chat/providers/chatProvider.dart';
import 'package:aigolive/chat/providers/notificationProvider.dart';
import 'package:aigolive/chat/widgets/chatWidgets.dart';
import 'package:aigolive/chat/widgets/notificationWidgets.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  // final int _initialIndex;
  // final bool _isNeedPop;

  // const NotificationsScreen(this._initialIndex, this._isNeedPop);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  //variables

  int _value = 0;
  fetchIsLogin() async {
    // print("LTPL: getting value from  sp");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('status') &&
        sharedPreferences.getString("status") == "success") {
      var id = sharedPreferences.getString("user_id");
      var status = sharedPreferences.getString("status");
      await Provider.of<NotificationProvider>(context, listen: false)
          .fetchNotificationData(id);
       await Provider.of<ChatProvider>(context, listen: false)
          .fetchConversationsData(id);
      await Provider.of<Purchases>(context, listen: false).fetchData();
    }
    // return true;
  }

  @override
  void initState() {
    super.initState();
    fetchIsLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _value,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
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
        body: SafeArea(
          child: Column(
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: MyColors().blueDark,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  // onTap: ,
                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MESSAGES',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2),
                            Icon(Icons.wifi),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'CHAT',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2),
                            Icon(Icons.message_outlined),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    NotificationWidgets(),
                    ChatWidgets(),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(1),
      ),
    );
  }
}
