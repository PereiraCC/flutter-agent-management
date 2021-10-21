import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:agent_management/global/environment.dart';
import 'package:agent_management/models/user.dart';
import 'package:agent_management/providers/user_provider.dart';

class UserService { 

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

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

  static Future<bool> googleSing(BuildContext context) async {

    try {
      
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account!.authentication;

      Uri url = Uri.parse('${Environment.apiAuthGoogleUrl}');

      final data = {
        'id_token' : googleKey.idToken
      };

      final resp = await http.post(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
        },
        body: jsonEncode(data)
      );

      final decodedData = json.decode(resp.body);

      if(resp.statusCode == 200) {

        userProvider.token = decodedData['token'];
        return true;

      } else {

        userProvider.msgError = 'Error: Sing in with google';
        return false;

      }
      
    } catch (err) {
      print('Error: $err');
      return false;
    }
  }
}