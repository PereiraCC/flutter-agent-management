import 'package:flutter/material.dart';

import 'package:agent_management/models/user.dart';

class UserProvider with ChangeNotifier {

  String _msgError = '';
  String _token    = '';
  bool _isLogin    = false;
  bool _isCreate   = false;
  User _user       = User.empty();

  String get msgError => this._msgError;
  set msgError(String msgError) {
    this._msgError = msgError;
  }

  String get token => this._token;
  set token(String token) {
    this._token = token;
  }

  bool get isLogin => this._isLogin;
  set isLogin(bool isLogin){
    this._isLogin = isLogin;
    notifyListeners();
  }

  bool get isCreate => this._isCreate;
  set isCreate(bool isCreate){
    this._isCreate = isCreate;
    notifyListeners();
  }

  User get user => this._user;
  set user(User user){
    this._user = user;
    notifyListeners();
  }

}