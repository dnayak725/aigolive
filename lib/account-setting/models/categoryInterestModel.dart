import 'package:flutter/foundation.dart';

class CategoryInterestModel {
  final String text;
  final String value;
  bool selected;
  final String disabled;

  CategoryInterestModel({
    @required this.text,
    @required this.value,
    @required this.selected,
    @required this.disabled,
  });
}
