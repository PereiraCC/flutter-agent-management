// To parse this JSON data, do
//
//     final agent = agentFromJson(jsonString);

import 'dart:convert';

List<Agent> agentFromJson(String str) => List<Agent>.from(json.decode(str).map((x) => Agent.fromJson(x)));

String agentToJson(List<Agent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agent {
    Agent({
        this.uid,
        this.profileImage,
        required this.google,
        required this.email,
        required this.identification,
        required this.name,
    });

    String? uid;
    String? profileImage;
    bool google;
    String email;
    String identification;
    String name;

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        uid: json["uid"],
        profileImage: json["profile_image"],
        google: json["google"],
        email: json["email"],
        identification: json["identification"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "profile_image": profileImage,
        "google": google,
        "email": email,
        "identification": identification,
        "name": name,
    };
}
