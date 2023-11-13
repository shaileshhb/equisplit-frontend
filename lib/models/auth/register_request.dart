// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    // required this.username,
    // this.gender,
    // this.contact,
    // this.dateOfBirth,
    // this.profileImage,
    // isVerified,
  });

  String name;
  String email;
  String password;
  // String username;
  // String? gender;
  // String? contact;
  // String? dateOfBirth;
  // String? profileImage;
  // bool isVerified = false;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        // username: json["username"],
        // gender: json["gender"],
        // contact: json["contact"],
        // dateOfBirth: json["dateOfBirth"],
        // profileImage: json["profileImage"],
        // isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        // "username": username,
        // "gender": gender,
        // "contact": contact,
        // "dateOfBirth": dateOfBirth,
        // "profileImage": profileImage,
        // "isVerified": isVerified,
      };
}
