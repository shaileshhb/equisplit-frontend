import 'dart:convert';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  int? id;
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
        id: json["id"],
        name: json["name"],
        createdBy: json["createdBy"],
        totalSpent: double.parse(json["totalSpent"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdBy": createdBy,
        "totalSpent": totalSpent,
      };
}
