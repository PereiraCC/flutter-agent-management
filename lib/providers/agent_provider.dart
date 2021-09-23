

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:agent_management/models/agent.dart';
import 'package:agent_management/global/environment.dart';

class AgentManamegentProvider with ChangeNotifier {

  List<Agent> _agents = [];
  Agent _newAgent = new Agent.empty();

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

}