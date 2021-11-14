
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:agent_management/models/agent.dart';
import 'package:agent_management/providers/db_access_provider.dart';

class AgentManamegentProvider with ChangeNotifier {

  String _countAgent = '';
  bool _loading = false;
  bool _updating = false;
  bool _isChangePhoto = false;
  bool _back = true;
  File _photo = new File('');
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

  bool get isChangePhoto => _isChangePhoto;
  set isChangePhoto(bool data) {
    this._isChangePhoto = data;
    notifyListeners();
  }

  bool get back => _back;
  set back(bool data) {
    this._back = data;
  }

  File get photo => _photo;
  set photo(File data) {
    this._photo = data;
    notifyListeners();
  }

  List<Agent> get agents => _agents;
  
  Agent get agent => _agent;
  set agent(Agent data) {
    this._agent = data;
    notifyListeners();
  }

  getAllAgents() async {

    try {
      final agent = await DbAccessProvider.db.getAllClients();
      this._agents = [...agent];
      countAgent = this._agents.length.toString();
      notifyListeners();

    } catch (err) {
      print('Error $err');
    }

  }

  Future<List<Agent>> getSearchAgents(String query) async {

    try {
      
      return this._agents.where((e) => 
        (e.name!.toLowerCase() == query.toLowerCase() 
          || e.identification!.toLowerCase() == query.toLowerCase()
          || e.lastname!.toLowerCase() == query.toLowerCase()
        )).toList();
    } catch (err) {
      print('Error $err');
      return [];
    }

  }
}