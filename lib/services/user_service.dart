import 'dart:convert';
import 'package:agent_management/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:agent_management/global/environment.dart';
import 'package:agent_management/models/user.dart';
import 'package:provider/provider.dart';

class UserService { 

  static Future<bool> createUser(User user) async {

    try {
      
      Uri url = Uri.parse('${Environment.apiUserUrl}');

      final resp = await http.post(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
        },
        body: jsonEncode(user.toJsonServices())
      );

      if (resp.statusCode == 201) {
        return true;
      } else {
        return false;
      }
      
    } catch (err) {
      print('error: $err');
      return false;
    }

  }

  static Future<bool> login(String email, String pass, BuildContext context) async {

    try {
      
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      Uri url = Uri.parse('${Environment.apiAuthLoginUrl}');

      final data = {
        'email'    : email,
        'password' : pass
      };

      final resp = await http.post(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
        },
        body: jsonEncode(data)
      );
      
      final decodedData = json.decode(resp.body);

      if (resp.statusCode == 200) {

        userProvider.token = decodedData['token'];
        userProvider.user = User.fromJson(decodedData['documents'][0]);
        return true;

      } else if(resp.statusCode == 400 || resp.statusCode == 404) {

        userProvider.msgError = decodedData['msg'];
        return false;

      } else {

        return false;

      }

    } catch (err) {
      print('Error: $err');
      return false;
    }

  }

  static Future<bool> googleSing() async {

    try {
      
      // TODO: Implementation of google sing - configuration QAuth client google console
      return true;


    } catch (err) {
      print('Error: $err');
      return false;
    }

  }
}