// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

import 'package:equisplit_frontend/models/auth/user.dart';
import 'package:equisplit_frontend/models/group/group.dart';

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
    this.group,
    this.invitedByUser,
  });

  String? id;
  String userId;
  String groupId;
  String? invitedBy;
  bool? isAccepted;
  User? user;
  Group? group;
  User? invitedByUser;

  factory Invitation.fromJson(Map<String, dynamic> body) => Invitation(
        id: body["id"],
        userId: body["userId"],
        groupId: body["groupId"],
        invitedBy: body["invitedBy"],
        isAccepted: body["isAccepted"],
        user: body["user"] != null
            ? userFromJson(json.encode(body["user"]))
            : null,
        group: body["group"] != null
            ? groupFromJson(json.encode(body["group"]))
            : null,
        invitedByUser: body["invitedByUser"] != null
            ? userFromJson(json.encode(body["invitedByUser"]))
            : null,
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
