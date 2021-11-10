import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:agent_management/models/agent.dart';
import 'package:agent_management/global/environment.dart';

import 'package:agent_management/services/user_service.dart';
import 'package:agent_management/providers/db_access_provider.dart';

class AgentService {

  static Future<bool> createAgent(Agent agent, String token) async {

    try {
      
      Uri url = Uri.parse('${Environment.apiAgentsUrl}');

      final resp = await http.post(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
          'x-token'      : token
        },
        body: jsonEncode(agent.toJsonServices())
      );

      return resp.statusCode == 201;

    } catch (err) {
      print('error: $err');
      return false;
    }
  }

  static Future<void> getAllAgentsServices() async {

    try {
      
      String userID = await UserService.readUserID();

      final url = Uri.parse('${Environment.apiAgentsUrl}/$userID');
      final resp = await http.get(url);

      if(resp.statusCode == 200){

        final decodedData = json.decode(resp.body);
        final agents = Agents.fromJsonList(decodedData['documents']);

        DbAccessProvider.db.deleteAllAgents();

        for (Agent agent in agents.items) {
          DbAccessProvider.db.newAgent(agent);
        }

      }

    } catch (err) {
      print('Error $err');
    }
  }

  static Future<bool> updateAgent(Agent agent, String token) async {

    try {

      String userID = await UserService.readUserID();

      Uri url = Uri.parse('${Environment.apiAgentsUrl}/$userID/${agent.identification}');
      
      final resp = await http.put(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
          'x-token'      : token
        },
        body: jsonEncode(agent.toJsonServices())
      );

      return resp.statusCode == 200;

    } catch (err) {
      print('Error $err');
      return false;
    }

  }

  static Future<bool> deleteAgent(String identification, String token) async {

    try {

      if(identification == 'no-identification') return false;

      String userID = await UserService.readUserID();

      Uri url = Uri.parse('${Environment.apiAgentsUrl}/$userID/$identification');
      
      final resp = await http.delete(url,
        headers: {
          'x-token' : token
        }
      );

       return resp.statusCode == 200;

    } catch (err) {
      print('Error $err');
      return false;
    }

  }

  static Future<bool> uploadImage(String identification, File photo, String token) async {

    try {

      if(identification == '') return false;

      String userID = await UserService.readUserID();

      Uri url = Uri.parse('${Environment.apiUploadAgentsUrl}/$identification?userID=$userID');
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
}