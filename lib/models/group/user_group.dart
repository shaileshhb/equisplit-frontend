import 'dart:convert';

import 'package:equisplit_frontend/models/auth/user.dart';
import 'package:equisplit_frontend/models/group/group.dart';

UserGroupEntity userGroupFromJson(String str) =>
    UserGroupEntity.fromJson(json.decode(str));

List<UserGroupEntity> userGroupsFromJson(String str) =>
    List<UserGroupEntity>.from(
        json.decode(str).map((x) => UserGroupEntity.fromJson(x)));

String userGroupToJson(UserGroupEntity data) => json.encode(data.toJson());

class UserGroupEntity {
  String? id;
  User? user;
  Group? group;
  String groupId;
  double outgoingAmount;
  double incomingAmount;
  dynamic summary;

  UserGroupEntity({
    this.id,
    required this.groupId,
    this.outgoingAmount = 0,
    this.incomingAmount = 0,
    this.user,
    this.group,
    this.summary,
  });

  factory UserGroupEntity.fromJson(Map<String, dynamic> body) =>
      UserGroupEntity(
        id: body["id"],
        groupId: body["groupId"],
        user: body["user"] != null
            ? userFromJson(json.encode(body["user"]))
            : null,
        group: body["group"] != null
            ? groupFromJson(json.encode(body["group"]))
            : null,
        outgoingAmount: double.parse(body["outgoingAmount"].toString()),
        incomingAmount: double.parse(body["incomingAmount"].toString()),
        summary: body["summary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupId": groupId,
        "user": user,
        "group": group,
        "outgoingAmount": outgoingAmount,
        "incomingAmount": incomingAmount,
        "summary": summary,
      };
}
