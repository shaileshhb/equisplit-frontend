// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Invitation invitationFromJson(String str) =>
    Invitation.fromJson(json.decode(str));

List<Invitation> invitationsFromJson(String str) =>
    List<Invitation>.from(json.decode(str).map((x) => Invitation.fromJson(x)));

String invitationToJson(Invitation data) => json.encode(data);

class Invitation {
  Invitation({
    required this.userId,
    required this.groupId,
    this.invitedBy,
    this.isAccepted,
  });

  String userId;
  String groupId;
  String? invitedBy;
  bool? isAccepted;

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
        userId: json["userId"],
        groupId: json["groupId"],
        invitedBy: json["invitedBy"],
        isAccepted: json["isAccepted"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "groupId": groupId,
        "invitedBy": invitedBy,
        "isAccepted": isAccepted,
      };
}
