import 'package:aigolive/account-setting/models/addressModel.dart';
import 'package:aigolive/account-setting/providers/userProfileProvider.dart';
import 'package:aigolive/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AddressesWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider, child) {
      List<AddressModel> address = userProfileProvider.addresses;
      // print("address:" + address.length.toString());
      return Column(
        children: List.generate(
          address.length,
          (index) => Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        address[index].phone,
                      ),
                      Text(
                        address[index].address,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 5,
                  child: Row(
                    children: [
                      address[index].isDefault != "1"
                          ? InkWell(
                              onTap: () {
                                userProfileProvider
                                    .makeAddressDefault(address[index].id);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                decoration: new BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  'Make Default',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                'Default',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                      //IconButton(
                       // padding: const EdgeInsets.symmetric(
                      //    vertical: 4,
                      //    horizontal: 6,
                      //  ),
                      //  constraints: BoxConstraints(),
                      //  iconSize: 22,
                      //  icon: Icon(Icons.edit),
                      //  onPressed: () {},
                      //  color: Colors.blue,
                      //),
                      // IconButton(
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 4,
                      //     horizontal: 6,
                      //   ),
                      //   constraints: BoxConstraints(),
                      //   iconSize: 22,
                      //   icon: Icon(Icons.delete),
                      //   onPressed: () {
                      //     userProfileProvider.deleteAddress(address[index].id);
                      //   },
                      //   color: Colors.red,
                      // ),
                    ],
                  ),
                )
              ],
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  userProfileProvider.deleteAddress(address[index].id);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
