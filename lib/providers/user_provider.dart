

import 'package:flutter/material.dart';

import 'package:agent_management/models/user.dart';

class UserProvider with ChangeNotifier {

  String _token    = '';
  String _msgError = '';
  User _user       = User.empty();

  String get token => this._token;
  set token(String token) {
    this._token = token;
    notifyListeners();
  }

  String get msgError => this._msgError;
  set msgError(String msgError) {
    this._msgError = msgError;
  }

  User get user => this._user;
  set user(User user){
    this._user = user;
    notifyListeners();
  }

}