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
  int? id;
  User? user;
  Group? group;
  int groupId;
  double outgoingAmount;
  double incomingAmount;

  UserGroupEntity({
    this.id,
    required this.groupId,
    this.outgoingAmount = 0,
    this.incomingAmount = 0,
    this.user,
    this.group,
  });

  factory UserGroupEntity.fromJson(Map<String, dynamic> body) =>
      UserGroupEntity(
        id: body["id"],
        groupId: body["groupId"],
        user: body["user"] != null
            ? userFromJson(json.encode(body["user"]))
            : null,
        group: groupFromJson(json.encode(body["group"])),
        outgoingAmount: double.parse(body["outgoingAmount"].toString()),
        incomingAmount: double.parse(body["incomingAmount"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupId": groupId,
        "user": user,
        "group": group,
        "outgoingAmount": outgoingAmount,
        "incomingAmount": incomingAmount,
      };
}
