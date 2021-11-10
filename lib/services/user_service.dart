import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:agent_management/models/user.dart';
import 'package:agent_management/global/environment.dart';
import 'package:agent_management/providers/user_provider.dart';

class UserService { 

  static final storage = new FlutterSecureStorage();

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
        await storage.write(key: 'token', value: decodedData['token']);
        userProvider.user = User.fromJson(decodedData['documents'][0]);
        await storage.write(key: 'userID',         value: userProvider.user.uid);
        await storage.write(key: 'identification', value: userProvider.user.identification);
        await storage.write(key: 'name',           value: userProvider.user.name);
        await storage.write(key: 'email',          value: userProvider.user.email);
        await storage.write(key: 'password',       value: userProvider.user.password);
        await storage.write(key: 'profileImage',   value: userProvider.user.profileImage);
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

      if(resp.statusCode == 200 || resp.statusCode == 201) {

        userProvider.token = decodedData['token'];
        await storage.write(key: 'token', value: decodedData['token']);
        userProvider.user = User.fromJson(decodedData['documents'][0]);
        await storage.write(key: 'userID',         value: userProvider.user.uid);
        await storage.write(key: 'identification', value: userProvider.user.identification);
        await storage.write(key: 'name',           value: userProvider.user.name);
        await storage.write(key: 'email',          value: userProvider.user.email);
        await storage.write(key: 'password',       value: userProvider.user.password);
        await storage.write(key: 'profileImage',   value: userProvider.user.profileImage);
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

  static Future<bool> updateUser(BuildContext context, User user) async {
    try {
      
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      Uri url = Uri.parse('${Environment.apiUserUrl}/${user.identification}');

      final resp = await http.put(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
          'x-token'      : userProvider.token
        },
        body: jsonEncode(user.toJsonServices())
      );
      
      final decodedData = json.decode(resp.body);

      if (resp.statusCode == 200) {

        userProvider.user = User.fromJson(decodedData['user'][0]);
        await storage.write(key: 'name',           value: userProvider.user.name);          
        await storage.write(key: 'password',       value: userProvider.user.password);
        await storage.write(key: 'profileImage',   value: userProvider.user.profileImage);
        return true;

      } else if(resp.statusCode == 400 || resp.statusCode == 401 || resp.statusCode == 404) {

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

  static Future<bool> uploadImageUser(String identification, File photo, String token) async {

    try {

      if(identification == '') return false;

      Uri url = Uri.parse('${Environment.apiUploadUsersUrl}/$identification');
      final mimeType = mime(photo.path)!.split('/');
      
      final imageUploadRequest = http.MultipartRequest(  
        'PUT',
        url
      );

      final file = await http.MultipartFile.fromPath(
        'file', 
        photo.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );

      imageUploadRequest.files.add(file);
      imageUploadRequest.headers.addAll({
        'x-token' : token
      });

      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);
      
      return resp.statusCode == 200;

    } catch (err) {
      print('error: $err');
      return false;
    }
  }

  static Future logout() async {
    try {
      
      await storage.delete(key: 'token');
      await storage.delete(key: 'userID');
      await storage.delete(key: 'identification');
      await storage.delete(key: 'name');
      await storage.delete(key: 'email');
      await storage.delete(key: 'password');
      await storage.delete(key: 'profileImage');
      return;

    } catch (e) {
      print('Error in logount: $e');
    }

  }

  static Future<String> readToken(BuildContext context) async {

    try {
      
      String token = await storage.read(key: 'token') ?? '';

      if(token != ''){

        Uri url = Uri.parse('${Environment.apiAuthValidUrl}');
        final resp = await http.post(url, 
          headers: {
            'Content-Type' : 'application/json; charset=utf-8',
          },
          body: jsonEncode({'token' : token})
        );
      
        if(resp.statusCode == 200){
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.token = token;
          return token;
        }
      }
      
      return '';

    } catch (e) {
      print('Error in readToken $e');
      return '';
    }
  }
  
  static Future<String> readUserID() async {

    try {
      
      return await storage.read(key: 'userID') ?? '';

    } catch (e) {
      print('Error $e');
      return '';
    }
  }

  static Future<bool> readUser(BuildContext context) async {

    try {

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final user = User(
        identification: await storage.read(key: 'identification') ?? '',
        name:           await storage.read(key: 'name') ?? '',
        email:          await storage.read(key: 'email') ?? '',
        password:       await storage.read(key: 'password') ?? '',
        profileImage:   await storage.read(key: 'profileImage') ?? '',
      );

      userProvider.user = user;

      return true;

    } catch (e) {
      print('Error $e');
      return false;
    }
  }
}