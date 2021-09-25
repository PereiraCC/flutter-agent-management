

import 'dart:convert';
import 'package:http/http.dart' as http;

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


}