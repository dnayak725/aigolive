import 'package:aigolive/config/colors.dart';
import 'package:aigolive/landing/Helpers/AppBarPopButton.dart';
import 'package:aigolive/stores/models/product_model.dart';
import 'package:aigolive/stores/widgets/products_widgets.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class SessionDetails extends StatefulWidget {
  final ProductModel product;

  const SessionDetails(this.product);

  @override
  _SessionDetailsState createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
  int _quantity = 1;
  List<bool> isSelected;
  final TextEditingController _emailController =
      new TextEditingController(text: 'nick@gmail.com');
  bool _isEnablePlaceOrder = false;
  _enablePlaceOrderMode() {
    setState(() {
      _isEnablePlaceOrder = true;
    });
  }

  _disablePlaceOrderMode() {
    setState(() {
      _isEnablePlaceOrder = false;
    });
  }

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyColors().lightGrey,
      backgroundColor: MyColors().lightGrey,
      appBar: AppBar(
        title: Text('Session Name'),
        centerTitle: true,
        leading: AppBarPopButton(),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Container(
                    // margin: EdgeInsets.symmetric(
                    //   horizontal: 6,
                    // ),
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.width - 30,

                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                        image: NetworkImage(widget.product.image),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    // child: Image.asset('assets/images/Apparel-Kids.png',),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.productName,
                              // style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                Text('\$' + widget.product.mrp.toString(),
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontSize: 12,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    '\$' +
                                        widget.product.sellingPrice.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Text(
                                    'Color',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 12),
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Color(0xFF2f5a9e),
                                      ),
                                      child: Text(
                                        'Blue',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 10),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      'Black',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Text(
                                    'Size',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF2f5a9e),
                                      ),
                                      child: Text(
                                        'S',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 4),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 4),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.circular(30.0),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        ' L ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 4),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        'XL',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Text(
                                    'Quantity ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_quantity > 1) {
                                        setState(() {
                                          _quantity--;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 22,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: new BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                          bottom: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                          left: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                          right: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 22,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: new BoxDecoration(
                                      border: Border(
                                        // left: BorderSide.none,
                                        top: BorderSide(
                                            width: 0.5, color: Colors.grey),
                                        bottom: BorderSide(
                                            width: 0.5, color: Colors.grey),
                                        // color: Colors.black,
                                        // width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      _quantity.toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                    child: Container(
                                      height: 22,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: new BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                          bottom: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                          left: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                          right: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '5 piece available',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: -10,
                          top: -10,
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              size: 20,
                              // color: Colors,
                            ),
                            onPressed: () {
                              Share.share('Session name is Name1');
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ProductsWidgets('123'),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 5 Vertically
                  ),
                )
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$' + widget.product.sellingPrice.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: _enablePlaceOrderMode,
                    child: Container(
                      // margin: EdgeInsets.only(top: 8),
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xFF13264c),
                        border: Border.all(
                          color: Color(0xFF13264c),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        'Buy Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _isEnablePlaceOrder
              ? SingleChildScrollView(
                  child: GestureDetector(
                    // onTap: _disablePlaceOrderMode(),
                    onTap: () {
                      print('object');
                      setState(() {
                        _isEnablePlaceOrder = false;
                      });
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
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
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
                                    onPressed: _disablePlaceOrderMode,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SizedBox(
                                    height: 10,
                                  ),
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
                                controller: _emailController,
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
                                      borderSide:
                                          BorderSide(color: Colors.white70)),
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
                                                      decoration: TextDecoration
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
                                    width: (MediaQuery.of(context).size.width -
                                            50) *
                                        0.5,
                                    constraints: BoxConstraints(maxWidth: 200),
                                    height: 60,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.all(Radius.circular(5),
                                      border: Border.all(
                                        color: isSelected[0]
                                            ? Colors.deepOrange
                                            : Colors.grey,
                                        width: isSelected[0] ? 2 : 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    width: (MediaQuery.of(context).size.width -
                                            50) *
                                        0.5,
                                    constraints: BoxConstraints(maxWidth: 200),
                                    height: 60,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.all(Radius.circular(5),
                                      border: Border.all(
                                        color: isSelected[1]
                                            ? Colors.deepOrange
                                            : Colors.grey,
                                        width: isSelected[0] ? 2 : 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      'Pay Now',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = i == index;
                                    }
                                  });
                                },
                                isSelected: isSelected,
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
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color:
                                                MyColors().toShipButtonColor)),
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
                                    color: MyColors().orderCancelButtonColor,
                                    textColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    onPressed: _disablePlaceOrderMode,
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
              : Container(),
        ],
      ),
    );
  }
}