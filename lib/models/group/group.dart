import 'dart:convert';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  String? id;
  String name;
  int createdBy;
  double totalSpent;

  Group({
    this.id,
    required this.name,
    required this.createdBy,
    this.totalSpent = 0,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        name: json["name"],
        createdBy: json["createdBy"],
        totalSpent: json["totalSpent"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "createdBy": createdBy,
        "totalSpent": totalSpent,
        // "username": username,
        // "gender": gender,
        // "contact": contact,
        // "dateOfBirth": dateOfBirth,
        // "profileImage": profileImage,
        // "isVerified": isVerified,
      };
}
