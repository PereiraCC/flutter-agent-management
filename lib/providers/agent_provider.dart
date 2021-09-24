
import 'package:flutter/material.dart';

import 'package:agent_management/models/agent.dart';
import 'package:agent_management/providers/db_access_provider.dart';

class AgentManamegentProvider with ChangeNotifier {

  String _countAgent = '';
  bool _loading = false;
  List<Agent> _agents = [];
  Agent _newAgent = new Agent.empty();

  String get countAgent => _countAgent;
  set countAgent(String data) {
    this._countAgent = data;
    notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool data) {
    this._loading = data;
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

  Future<List<Agent>> getAllAgents() async {

    try {
      
      agents = await DbAccessProvider.db.getAllClients();
      return agents;

    } catch (err) {
      print('Error $err');
      return [];
    }

  }

}