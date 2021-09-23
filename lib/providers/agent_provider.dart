

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:agent_management/models/agent.dart';
import 'package:agent_management/global/environment.dart';

class AgentManamegentProvider with ChangeNotifier {

  String _countAgent = '';
  List<Agent> _agents = [];
  Agent _newAgent = new Agent.empty();

  String get countAgent => _countAgent;
  set countAgent(String data) {
    this._countAgent = data;
    notifyListeners();
  }

  List<Agent> get agents => _agents;
  set agents(List<Agent> data) {
    this._agents = data;
    notifyListeners();
  }

  Agent get newAgent => _newAgent;
  set newAgent(Agent data) {
    this._newAgent = data;
    notifyListeners();
  }

  Future<bool> createAgent(Agent agent) async {

    try {
      
      Uri url = Uri.parse('${Environment.apiAgentsUrl}');

      // print(agent.toJson());

      final resp = await http.post(url, 
        headers: {
          'Content-Type' : 'application/json; charset=utf-8',
        },
        body: jsonEncode(agent.toJson())
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

  Future<List<Agent>> getAllAgents() async {

    try {
      
      final url = Uri.parse('${Environment.apiAgentsUrl}');
      final resp = await http.get(url);

      if(resp.statusCode == 200){

        final decodedData = json.decode(resp.body);
        final agents = Agents.fromJsonList(decodedData['documents']);

        this.agents = agents.items;
        notifyListeners();
        return this.agents;
      }

      return [];

    } catch (err) {
      print('Error $err');
      return [];
    }

  }

}