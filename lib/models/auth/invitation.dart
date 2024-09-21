// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

import 'package:equisplit_frontend/models/auth/user.dart';

Invitation invitationFromJson(String str) =>
    Invitation.fromJson(json.decode(str));

List<Invitation> invitationsFromJson(String str) =>
    List<Invitation>.from(json.decode(str).map((x) => Invitation.fromJson(x)));

String invitationToJson(Invitation data) => json.encode(data);

class Invitation {
  Invitation({
    required this.userId,
    required this.groupId,
    this.id,
    this.invitedBy,
    this.isAccepted,
    this.user,
  });

  String? id;
  String userId;
  User? user;
  String groupId;
  String? invitedBy;
  bool? isAccepted;

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
        id: json["id"],
        userId: json["userId"],
        groupId: json["groupId"],
        invitedBy: json["invitedBy"],
        isAccepted: json["isAccepted"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "groupId": groupId,
        "invitedBy": invitedBy,
        "isAccepted": isAccepted,
        "user": user,
      };
}
