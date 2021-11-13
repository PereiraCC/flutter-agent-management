
import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Product({
        this.uid,
        this.userID,
        required this.code,
        required this.price,
        required this.available,
        this.profileImage,
        required this.title,
    });

    bool    available;
    int     price;
    String  code;
    String  title;
    String? profileImage;
    String? uid;
    String? userID;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        available    : json["available"],
        code         : json["code"],
        price        : json["price"],
        profileImage : json["profile_image"],
        title        : json["title"],
        uid          : json["uid"],
        userID       : json["userID"],
    );

    Map<String, dynamic> toJson() => {
        "available"     : available,
        "code"          : code,
        "price"         : price,
        "profile_image" : (profileImage == 'null') ? 'no-image' : profileImage,
        "title"         : title,
        "uid"           : uid,
        "userID"        : userID,
    };

    Map<String, dynamic> toJsonServices() => {
        "available"     : available,
        "code"          : code,
        "price"         : price,
        "title"         : title,
        "userID"        : userID,
    };
}
