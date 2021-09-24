
import 'package:flutter/material.dart';

import 'package:agent_management/models/agent.dart';
import 'package:agent_management/providers/db_access_provider.dart';

class AgentManamegentProvider with ChangeNotifier {

  String _countAgent = '';
  bool _loading = false;
  bool _updating = false;
  List<Agent> _agents = [];
  Agent _agent = new Agent.empty();

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

  bool get updating => _updating;
  set updating(bool data) {
    this._updating = data;
    notifyListeners();
  }

  List<Agent> get agents => _agents;
  set agents(List<Agent> data) {
    this._agents = data;
    notifyListeners();
  }

  Agent get agent => _agent;
  set agent(Agent data) {
    this._agent = data;
    notifyListeners();
  }

  Future<List<Agent>> getAllAgents() async {

    try {
      
      agents = await DbAccessProvider.db.getAllClients();
      countAgent = agents.length.toString();
      return agents;

    } catch (err) {
      print('Error $err');
      return [];
    }

  }

}