// To parse this JSON data, do
//
//     final agent = agentFromJson(jsonString);

import 'dart:convert';

List<User> agentFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String agentToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
