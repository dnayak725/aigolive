import 'package:flutter/material.dart';

class CheckStatusProvider with ChangeNotifier{
  bool _editStatus=false;

  //getters
  bool get editStatusValue{
    return _editStatus;
  }

  //setters
  void setEditStatus(val){
    _editStatus=val;
  }
}