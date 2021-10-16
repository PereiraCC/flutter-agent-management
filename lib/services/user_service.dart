import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:agent_management/global/environment.dart';
import 'package:agent_management/models/user.dart';

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


}