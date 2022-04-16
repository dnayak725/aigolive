import 'package:aigolive/account-setting/models/addressModel.dart';
import 'package:flutter/material.dart';

class CartAddressHelper extends StatelessWidget {
  final AddressModel address;
  CartAddressHelper({
    @required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            address.phone,
          ),
          Text(
            address.address,
          ),
        ],
      ),
    );
  }
}
