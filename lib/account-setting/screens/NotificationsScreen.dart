import 'package:flutter/material.dart';
import 'package:aigolive/account-setting/components/account_bar_pop_button.dart';
import 'package:aigolive/config/colors.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: MyColors().lightGrey,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Text('Your Bookmarked session is going to start soon!'),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 30) * 0.3,
                      child: Container(
                        height: 120,
                        width: 80,
                        margin: EdgeInsets.only(
                          right: 10,
                        ),
                        padding: EdgeInsets.all(20),
                        decoration: new BoxDecoration(
                          // border: Border.all(
                          //   color: Colors.red,
                          //   width: 2.5,
                          // ),
                          color: Colors.white,
                          // shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/images/img2.jpg"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 30) * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 7),
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: ((MediaQuery.of(context).size.width -
                                              30) *
                                          0.7) -
                                      50,
                                  child: Text(
                                      'All about music - Earphone, Earbuds, Speakers & Accessories'),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Share.share('text');
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.share,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Container(
                                // margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(7),
                                decoration: new BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  // color: Colors.white,
                                  shape: BoxShape.circle,
                                  // image: new DecorationImage(
                                  //   fit: BoxFit.contain,
                                  //   image: AssetImage("assets/images/wlogo.png"),
                                  // ),
                                ),
                                child: Image.asset(
                                  'assets/images/wlogo.png',
                                  width: 20,
                                ),
                              ),
                              Text(
                                "Shop Name",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 7),
                            child: Text('5th September 2020'),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 7),
                            child: Text('12:00'),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 7),
                            child: Text(
                              'Electronic',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 25),
                  color: Colors.white,
                  child: Text(
                    'Order Updates',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Order Number #224",
                          // style: Theme.of(context).textTheme.title,
                        ),
                        Icon(
                          Icons.chevron_right_sharp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "Paid on 18 August 2020 22:30:30",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          // margin: EdgeInsets.only(top: 3.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
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
                                          'https://5.imimg.com/data5/VB/HN/GLADMIN-12117779/samsung-washing-machine-wt655qpndrp-500x500.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 115,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Lorem ipsum dolor sit amet,'),
                                        Text('\$233.00'),
                                      ],
                                    ),
                                    Text(
                                      "x 2",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Row(
                                          children: [
                                            Text('Status:   '),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 12),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                border: Border.all(
                                                  color: MyColors()
                                                      .deliveredButtonColor,
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: Text(
                                                'To ship',
                                                style: TextStyle(
                                                    color: MyColors()
                                                        .deliveredButtonColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Total:  '),
                                        Text(
                                          "\$466.00",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1,),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Order Number #224",
                          // style: Theme.of(context).textTheme.title,
                        ),
                        Icon(
                          Icons.chevron_right_sharp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "Paid on 18 August 2020 22:30:30",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          // margin: EdgeInsets.only(top: 3.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
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
                                          'https://5.imimg.com/data5/VB/HN/GLADMIN-12117779/samsung-washing-machine-wt655qpndrp-500x500.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 115,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Lorem ipsum dolor sit amet,'),
                                        Text('\$233.00'),
                                      ],
                                    ),
                                    Text(
                                      "x 2",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Row(
                                          children: [
                                            Text('Status:   '),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 12),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(30.0),
                                                border: Border.all(
                                                  color: MyColors()
                                                      .deliveredButtonColor,
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: Text(
                                                'To ship',
                                                style: TextStyle(
                                                    color: MyColors()
                                                        .deliveredButtonColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Total:  '),
                                        Text(
                                          "\$466.00",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
