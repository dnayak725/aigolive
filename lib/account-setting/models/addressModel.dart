import 'package:flutter/foundation.dart';

class AddressModel {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String isDefault;

  AddressModel(
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.isDefault,
  );
}
