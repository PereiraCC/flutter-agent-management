

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:agent_management/models/agent.dart';
import 'package:agent_management/global/environment.dart';

import 'package:agent_management/providers/db_access_provider.dart';

class AgentService {

  static Future<bool> createAgent(Agent agent) async {

    try {
      
      Uri url = Uri.parse('${Environment.apiAgentsUrl}');

      // print(agent.toJson());

      final resp = await http.post(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
        },
        body: jsonEncode(agent.toJsonServices())
      );

      if (resp.statusCode == 201) {
        // print(resp.body[]);
        return true;
      } else {
        return false;
      }
      

    } catch (err) {
      print('error: $err');
      return false;
    }
  }

  static Future<void> getAllAgentsServices() async {

    try {
      
      final url = Uri.parse('${Environment.apiAgentsUrl}');
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
      // return [];
    }

  }

  static Future<bool> updateAgent(Agent agent) async {

    try {

       Uri url = Uri.parse('${Environment.apiAgentsUrl}/${agent.identification}');
      
      final resp = await http.put(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
        },
        body: jsonEncode(agent.toJsonServices())
      );

      if (resp.statusCode == 200) {
        // print(resp.body[]);
        return true;
      } else {
        return false;
      }

    } catch (err) {
      print('Error $err');
      return false;
    }

  }

  static Future<bool> deleteAgent(String identification) async {

    try {

      if(identification == 'no-identification') return false;

      Uri url = Uri.parse('${Environment.apiAgentsUrl}/$identification');
      
      final resp = await http.delete(url);

      if (resp.statusCode == 200) {
        // print(resp.body[]);
        return true;
      } else {
        return false;
      }

    } catch (err) {
      print('Error $err');
      return false;
    }

  }

  static Future<bool> uploadImage(String identification, File photo) async {

    try {

      if(identification == '') return false;

      Uri url = Uri.parse('${Environment.apiUploadAgentsUrl}/$identification');
      final mimeType = mime(photo.path)!.split('/');
      
      final imageUploadRequest = http.MultipartRequest(  
        'PUT',
        url
      );

      final file = await http.MultipartFile.fromPath(
        'file', 
        photo.path,
        contentType: MediaType(mimeType[0], mimeType[1])
      );

      imageUploadRequest.files.add(file);

      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);
      
      if (resp.statusCode == 200) {
        // print(resp.body[]);
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