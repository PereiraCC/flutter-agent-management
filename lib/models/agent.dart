import 'dart:convert';

class Agents {

  List<Agent> items = [];

  Agents();

  Agents.fromJsonList( List<dynamic> jsonList  ) {

    for ( var item in jsonList  ) {
      final agent = new Agent.fromJson(item);
      items.add( agent );
    }

  }

}

List<Agent> agentFromJson(String str) => List<Agent>.from(json.decode(str).map((x) => Agent.fromJson(x)));

String agentToJson(List<Agent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agent {
    Agent({
        this.idAgent,
        this.profileImage,
        required this.name,
        required this.lastname,
        required this.email,
        required this.phone,
        required this.identification,
    });

    Agent.empty();

    String? idAgent;
    String? name;
    String? lastname;
    String? email;
    String? phone;
    String? identification;
    String? profileImage;

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        identification : json['identification'].toString(),
        idAgent        : json['id_agent'].toString(),
        name           : json['name'].toString(),
        lastname       : json['lastname'].toString(),
        email          : json['email'].toString(),
        phone          : json['phone'].toString(),
        profileImage   : json['profile_image'].toString(),
    );

    Map<String, dynamic> toJson() => {
        'identification' : identification,
        'idAgent'        : idAgent,
        'name'           : name,
        'lastname'       : lastname,
        'email'          : email,
        'phone'          : phone,
        'profileAgent'   : profileImage,
    };

    Map<String, dynamic> toJsonServices() => {
        'identification' : identification,
        'name'           : name,
        'lastname'       : lastname,
        'email'          : email,
        'phone'          : phone,
    };
}
