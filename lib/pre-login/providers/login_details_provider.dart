import 'package:flutter/material.dart';

class LoginDetailsProvider with ChangeNotifier{
  String _token='Empty';
  String _loginMode='Empty';
  String _userName='Empty';
  String _photoUrl='Empty';
  
  String get token{
    return _token;
  }
  String get loginMode{
    return _loginMode;
  }
  String get userName{
    return _userName;
  }
  String get photoUrl{
    return _photoUrl;
  }

  void setToken(token){
    _token=token;
    notifyListeners();
  }
  void setLoginMode(mode){
    _loginMode=mode;
    notifyListeners();
  }
  void setUserName(name){
    _userName=name;
    notifyListeners();
  }
  void setPhotoUrl(url){
    _photoUrl=url;
    notifyListeners();
  }


}