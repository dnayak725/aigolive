import 'package:aigolive/account-setting/models/addressModel.dart';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/account-setting/screens/myAddressScreen.dart';
import 'package:aigolive/cart/Helpers/CartAddressHelper.dart';
import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyColors mycolor = new MyColors();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Delivery Address",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: mycolor.lightGrey,
        child: Consumer<UserProfileProvider>(
            builder: (context, userProfileProvider, child) {
          List<AddressModel> address = userProfileProvider.addresses;
          int addressSelectedIndex = address.indexWhere((element) =>
              element.id == userProfileProvider.selectedAddress.toString());
          return Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: List.generate(
                  address.length,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 10),
                    color: mycolor.whiteSection,
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: MyColors().iconColor,
                          value: addressSelectedIndex == index ? true : false,
                          onChanged: (bool value) {
                            userProfileProvider.changeSelectedAddress(
                                int.parse(address[index].id));
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 10,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          color: mycolor.whiteSection,
                          child: CartAddressHelper(
                            address: address[index],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: mycolor.whiteSection,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add a new address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: MyColors().iconColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAddressScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
