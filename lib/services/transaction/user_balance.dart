// To parse this JSON data, do
//
//     final userBalance = userBalanceFromJson(jsonString);

import 'dart:convert';

List<UserBalance> userBalanceFromJson(String str) => List<UserBalance>.from(
    json.decode(str).map((x) => UserBalance.fromJson(x)));

String userBalanceToJson(List<UserBalance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserBalance {
  String userId;
  User user;
  String groupId;
  int amount;

  UserBalance({
    required this.userId,
    required this.user,
    required this.groupId,
    required this.amount,
  });

  factory UserBalance.fromJson(Map<String, dynamic> json) => UserBalance(
        userId: json["user_id"],
        user: User.fromJson(json["user"]),
        groupId: json["group_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user": user.toJson(),
        "group_id": groupId,
        "amount": amount,
      };
}

class User {
  String id;
  DateTime createdAt;
  String name;
  String email;

  User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "email": email,
      };
}
