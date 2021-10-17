// To parse this JSON data, do
//
//     final agent = agentFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    User({
        this.uid,
        this.profileImage,
        this.password,
        this.google,
        required this.email,
        required this.identification,
        required this.name,
    });

    User.empty();

    String? uid;
    String? profileImage;
    String? password;
    bool? google;
    String? email;
    String? identification;
    String? name;

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

    Map<String, dynamic> toJsonServices() => {
        'identification' : identification,
        'name'           : name,
        'email'          : email,
        'password'       : password,
    };
}
