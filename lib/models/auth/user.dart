// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    required this.name,
    required this.email,
    this.amount,
    // required this.username,
    // this.dateOfBirth,
    // this.gender,
    // this.contact,
    // this.profileImage,
    // required this.isVerified,
  });

  String? id;
  String name;
  String email;
  double? amount = 0;
  bool? isChecked = false;
  // String username;
  // dynamic dateOfBirth;
  // dynamic gender;
  // dynamic contact;
  // dynamic profileImage;
  // bool isVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        // username: json["username"],
        // dateOfBirth: json["dateOfBirth"],
        // gender: json["gender"],
        // contact: json["contact"],
        // profileImage: json["profileImage"],
        // isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        // "username": username,
        // "dateOfBirth": dateOfBirth,
        // "gender": gender,
        // "contact": contact,
        // "profileImage": profileImage,
        // "isVerified": isVerified,
      };
}
