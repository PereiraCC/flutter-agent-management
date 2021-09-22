// To parse this JSON data, do
//
//     final agent = agentFromJson(jsonString);

import 'dart:convert';

Agent agentFromJson(String str) => Agent.fromJson(json.decode(str));

String agentToJson(Agent data) => json.encode(data.toJson());

class Agent {
    Agent({
        this.idAgent,
        required this.identification,
        required this.name,
        required this.lastname,
        required this.email,
        required this.phone,
    });

    String? idAgent;
    String name;
    String lastname;
    String email;
    String phone;
    String identification;

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        idAgent: json["id_agent"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        identification: json["identification"],
    );

    Map<String, dynamic> toJson() => {
        "id_agent": idAgent,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "identification": identification,
    };
}
