import 'dart:async';
import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:aigolive/account-setting/orders/providers/purchases.dart';
import 'package:aigolive/account-setting/orders/widgets/all_purchases_widgets.dart';
import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/BottomNav.dart';
import 'package:aigolive/pre-login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPurchasesScreen extends StatefulWidget {
  final int _initialIndex;
  final bool _isNeedPop;

  const MyPurchasesScreen(this._initialIndex, this._isNeedPop);

  @override
  _MyPurchasesScreenState createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen> {
  //variables

  int _value = 1;
  Timer _timer;
  syncData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('user_id')) {
      var userId = sharedPreferences.getString("user_id");
      Provider.of<Purchases>(context, listen: false).fetchData();
      // print("LTPL: profile data fetched");
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
      Provider.of<Purchases>(context, listen: false).reset();
      _timer?.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    syncData();
    _timer = Timer.periodic(Duration(seconds: 15), (Timer t) => syncData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget._isNeedPop.toString());
    // TODO: implement build
    return DefaultTabController(
      length: 6,
      initialIndex: widget._initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
          centerTitle: true,
          leading: widget._isNeedPop ? Container() : AccountBarPopButton(),
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
                      child: Text(
                        'All',
                        // style: TextStyle(
                        //   fontSize: 12,
                        // ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'To ship',
                        // style: TextStyle(
                        //   fontSize: 12,
                        // ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'To receive',
                        // style: TextStyle(
                        //   fontSize: 12,
                        // ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Delivered',
                        // style: TextStyle(
                        //   fontSize: 12,
                        // ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Cancellations',
                        // style: TextStyle(
                        //   fontSize: 12,
                        // ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Refunded',
                        // style: TextStyle(
                        //   fontSize: 12,
                        // ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AllPurchasesWidget("0"), //0 - all list
                    AllPurchasesWidget("1"), //1 - to ship list
                    AllPurchasesWidget("2"), //2 - to receive list
                    AllPurchasesWidget("3"), //3 - Delivered list
                    AllPurchasesWidget("4"), //4 - Cancelled list
                    AllPurchasesWidget("5"), //5 - Refunded list
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: widget._isNeedPop ? BottomNav(1) : SizedBox(),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, int orderNum) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Cancel order',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Order Numberq:  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('#' + orderNum.toString()),
                  ],
                ),
                Text(
                  'Cancel reason: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    for (int i = 1; i <= 5; i++)
                      ListTile(
                        title: Text(
                          'Radio $i $_value',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: i == 5 ? Colors.black38 : Colors.black),
                        ),
                        leading: Radio(
                          value: i,
                          groupValue: _value,
                          activeColor: Color(0xFF6200EE),
                          onChanged: i == 5
                              ? null
                              : (value) {
                                  setState(() {
                                    _value = value;
                                    print(_value);
                                  });
                                },
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Confirm',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
