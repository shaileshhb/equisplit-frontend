// To parse this JSON data, do
//
//     final user = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    this.id,
    required this.payerId,
    required this.payeeId,
    required this.groupId,
    required this.amount,
    this.description,
    this.isPaid,
    this.isAdjusted,
  });

  String? id;
  String payerId;
  String payeeId;
  String groupId;
  String? description;
  double amount = 0;
  bool? isPaid = false;
  bool? isAdjusted = false;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        payerId: json["payerId"],
        payeeId: json["payeeId"],
        groupId: json["groupId"],
        amount: json["amount"],
        description: json["description"],
        isPaid: json["isPaid"],
        isAdjusted: json["isAdjusted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payerId": payerId,
        "payeeId": payeeId,
        "groupId": groupId,
        "amount": amount,
        "description": description,
        "isPaid": isPaid,
        "isAdjusted": isAdjusted,
      };
}
