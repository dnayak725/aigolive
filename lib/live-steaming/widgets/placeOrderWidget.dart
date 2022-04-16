import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';

class PlaceOrderWidget extends StatefulWidget {
  final Function changeToProductViewMode;
  final TextEditingController emailController;
  final List<bool> isSelected;
  final Function changePayNowButtonStatus;
  const PlaceOrderWidget(
      {Key key,
      this.changeToProductViewMode,
      this.emailController,
      this.isSelected,
      this.changePayNowButtonStatus})
      : super(key: key);

  @override
  _PlaceOrderWidgetState createState() => _PlaceOrderWidgetState();
}

class _PlaceOrderWidgetState extends State<PlaceOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return (MediaQuery.of(context).orientation == Orientation.portrait)
        ? SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                widget.changeToProductViewMode();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3),
                color: Colors.black54,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                widget.changeToProductViewMode();
                              },
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shopping Address',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child: Text('Edit'),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Name',
                            ),
                            Text(
                              '+65 xxxxxxxxx',
                            ),
                            Text(
                              'Address -Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Billing Address',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      child: Text('Edit'),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Name',
                            ),
                            Text(
                              '+65 xxxxxxxxx',
                            ),
                            Text(
                              'Address -Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          // initialValue: _emailController.text,
                          // initialValue: _emailController.text,
                          controller: widget.emailController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 6, top: 0, bottom: 0),
                            // icon: Icon(Icons.email,
                            //     color: Theme.of(context).primaryColor),
                            // labelText: "Email",
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Women Shirt '),
                                    Row(
                                      children: [
                                        Text('\$50',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('\$30',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Text('Color: Blue'),
                                    Text('Size: S'),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Quantity: 1'),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text('1 Iteam(s), Total: \$30')],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Select Payment Method',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ToggleButtons(
                          renderBorder: false,
                          selectedBorderColor: Colors.red,
                          selectedColor: Colors.black,
                          fillColor: Colors.white,
                          children: <Widget>[
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                              width: (MediaQuery.of(context).size.width - 50) *
                                  0.5,
                              constraints: BoxConstraints(maxWidth: 200),
                              height: 60,
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                // borderRadius: BorderRadius.all(Radius.circular(5),
                                border: Border.all(
                                  color: widget.isSelected[0]
                                      ? Colors.deepOrange
                                      : Colors.grey,
                                  width: widget.isSelected[0] ? 2 : 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Credit Card',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    'XXX XXXXX XXXXX',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width: (MediaQuery.of(context).size.width - 50) *
                                  0.5,
                              constraints: BoxConstraints(maxWidth: 200),
                              height: 60,
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                // borderRadius: BorderRadius.all(Radius.circular(5),
                                border: Border.all(
                                  color: widget.isSelected[1]
                                      ? Colors.deepOrange
                                      : Colors.grey,
                                  width: widget.isSelected[0] ? 2 : 1.5,
                                ),
                              ),
                              child: Text(
                                'Pay Now',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                          onPressed: (int index) {
                            widget.changePayNowButtonStatus(index);
                          },
                          isSelected: widget.isSelected,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '1 Iteam(s), Total: \$30',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: MyColors().toShipButtonColor)),
                              color: MyColors().toShipButtonColor,
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              onPressed: () {},
                              child: Text(
                                "Place order",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color:
                                          MyColors().orderCancelButtonColor)),
                              color: MyColors().orderCancelButtonColor,
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              onPressed: () {
                                widget.changeToProductViewMode();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.black38,
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        // width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            left: 15, right: 10, bottom: 10, top: 50),
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.7 / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Shopping Address',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                child: Text('Edit'),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Name',
                                      ),
                                      Text(
                                        '+65 xxxxxxxxx',
                                      ),
                                      Text(
                                        'Address -Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Email',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    // initialValue: _emailController.text,
                                    // initialValue: _emailController.text,
                                    controller: widget.emailController,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black87),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 6, top: 0, bottom: 0),
                                      // icon: Icon(Icons.email,
                                      //     color: Theme.of(context).primaryColor),
                                      // labelText: "Email",
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
                                      hintStyle:
                                          TextStyle(color: Colors.black38),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('Women Shirt '),
                                              Row(
                                                children: [
                                                  Text('\$50',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Colors.grey)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('\$30',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Text('Color: Blue'),
                                              Text('Size: S'),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('Quantity: 1'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [Text('1 Iteam(s), Total: \$30')],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.85 / 2,
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Billing Address',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: Text('Edit'),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Name',
                                  ),
                                  Text(
                                    '+65 xxxxxxxxx',
                                  ),
                                  Text(
                                    'Address -Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Select Payment Method',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ToggleButtons(
                                    renderBorder: false,
                                    selectedBorderColor: Colors.red,
                                    selectedColor: Colors.black,
                                    fillColor: Colors.white,
                                    children: <Widget>[
                                      Container(
                                        // margin: EdgeInsets.symmetric(
                                        //     vertical: 4, horizontal: 4),
                                        width: ((MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85 /
                                                    2) -
                                                15) *
                                            0.5,
                                        constraints:
                                            BoxConstraints(maxWidth: 200),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 4),
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          // borderRadius: BorderRadius.all(Radius.circular(5),
                                          border: Border.all(
                                            color: widget.isSelected[0]
                                                ? Colors.deepOrange
                                                : Colors.grey,
                                            width:
                                                widget.isSelected[0] ? 2 : 1.5,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Credit Card',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              'XXX XXXXX XXXXX',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        width: ((MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85 /
                                                    2) -
                                                15) *
                                            0.5,
                                        constraints:
                                            BoxConstraints(maxWidth: 200),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 8),
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          // borderRadius: BorderRadius.all(Radius.circular(5),
                                          border: Border.all(
                                            color: widget.isSelected[1]
                                                ? Colors.deepOrange
                                                : Colors.grey,
                                            width:
                                                widget.isSelected[0] ? 2 : 1.5,
                                          ),
                                        ),
                                        child: Text(
                                          'Pay Now',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                    onPressed: (int index) {
                                      widget.changePayNowButtonStatus(index);
                                    },
                                    isSelected: widget.isSelected,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '1 Iteam(s), Total: \$30',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: MyColors()
                                                    .toShipButtonColor)),
                                        color: MyColors().toShipButtonColor,
                                        textColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 8),
                                        onPressed: () {},
                                        child: Text(
                                          "Place order",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: MyColors()
                                                    .orderCancelButtonColor)),
                                        color:
                                            MyColors().orderCancelButtonColor,
                                        textColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 8),
                                        onPressed: () {
                                          widget.changeToProductViewMode();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 25,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          // color: Colors,
                        ),
                        onPressed: () {
                          widget.changeToProductViewMode();
                        },
                      ),
                    )
                  ]),
                ),
              ],
            ),
          );
  }
}
