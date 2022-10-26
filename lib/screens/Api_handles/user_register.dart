import 'package:meta/meta.dart';
import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
    Register({
        required this.username,
        required this.email,
        required this.password,
        required this.cpassword,
        required this.contact,
        required this.address,
    });

    final String username;
    final String email;
    final String password;
    final String cpassword;
    final String contact;
    final String address;

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        cpassword: json["cpassword"],
        contact: json["contact"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "cpassword": cpassword,
        "contact": contact,
        "address": address,
    };
}
