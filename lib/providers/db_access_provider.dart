
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:agent_management/models/agent.dart';

class DbAccessProvider {

  static Database? _database;

  static final DbAccessProvider db = DbAccessProvider._();

  DbAccessProvider._();

  Future<Database> get database async {

    if(_database != null) return _database ?? await initDB();

    _database = await initDB();
    return _database ?? await initDB();
  }

  Future<Database> initDB() async {

    Directory dbDirectory = await getApplicationDocumentsDirectory();
    final path = join(dbDirectory.path, 'Agents.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Agent(
            id INTEGER PRIMARY KEY,
            idAgent TEXT,
            identification TEXT,
            name TEXT,
            lastname TEXT,
            email TEXT,
            phone TEXT,
            profileImage TEXT,
            status TEXT
          )
        ''');
      }
    );
  }

  Future<int> newAgent(Agent newAgent) async {
    try {
      
      final db = await database;
      return await db.insert('Agent', newAgent.toJson());

    } catch (err) {
      print('Error Sqflite Insert: $err');
      return 0;
    }
  }

  Future<int> deleteAllAgents() async {
    try {
      
      final db = await database;
      return await db.delete('Agent');

    } catch (err) {
      print('Error Sqflite delete all: $err');
      return 0;
    }
  }

  Future<List<Agent>> getAllClients() async {

     try {
      
      final db = await database;
      final resp = await db.query('Agent');

      return resp.isNotEmpty ? resp.map((e) => Agent.fromJson(e)).toList() : [];

    } catch (err) {
      print('Error Sqflite get all: $err');
      return [];
    }

  }

  Future<List<Agent>> getAgentByIdentification(String id) async {

    try {
      
      final db = await database;
      final res = await db.rawQuery('''
        SELECT * FROM Agent where identification='$id'
      ''');
      return res.isNotEmpty ? res.map((s) => Agent.fromJson(s)).toList() : [];

    } catch (err) {
      print('Error Sqflite get by ID: $err');
      return [];
    }

    
  }

  Future<int> updateClient(Agent newAgent) async {

    try {
      
      final db = await database;
      return await db.update('Agent', newAgent.toJson(),
                      where: 'id=?', whereArgs: [newAgent.identification]);

    } catch (err) {
      print('Error Sqflite Insert: $err');
      return 0;
    }
    
  }

  Future<int> deleteClient(int identification) async {

    try {
      
      final db = await database;
      return await db.delete('Agent', where: 'identification=?', whereArgs: [identification]);

    } catch (err) {
      print('Error Sqflite delete an agent: $err');
      return 0;
    }
    
  }

}