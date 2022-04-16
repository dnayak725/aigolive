import 'package:aigolive/stores/models/product_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aigolive/config/config.dart';

class StoreProductProvider with ChangeNotifier {
  List<ProductModel> productList = [];
  String status = "fetching data.";
}
