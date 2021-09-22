// To parse this JSON data, do
//
//     final agent = agentFromJson(jsonString);

import 'dart:convert';

List<Agent> agentFromJson(String str) => List<Agent>.from(json.decode(str).map((x) => Agent.fromJson(x)));

String agentToJson(List<Agent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agent {
    Agent({
        this.idAgent,
        required this.name,
        required this.lastname,
        required this.email,
        required this.phone,
        required this.identification,
    });

    String? idAgent;
    String name;
    String lastname;
    String email;
    String phone;
    String identification;

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        identification : json['identification'],
        idAgent        : json['id_agent'],
        name           : json['name'],
        lastname       : json['lastname'],
        email          : json['email'],
        phone          : json['phone'],
    );

    Map<String, dynamic> toJson() => {
        'identification' : identification,
        'id_agent'       : idAgent,
        'name'           : name,
        'lastname'       : lastname,
        'email'          : email,
        'phone'          : phone,
    };
}
