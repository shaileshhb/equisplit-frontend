// To parse this JSON data, do
//
//     final multipleTransaction = multipleTransactionFromJson(jsonString);

import 'dart:convert';

List<MultipleTransaction> multipleTransactionFromJson(String str) =>
    List<MultipleTransaction>.from(
        json.decode(str).map((x) => MultipleTransaction.fromJson(x)));

String multipleTransactionToJson(List<MultipleTransaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MultipleTransaction {
  String payeeId;
  int amount;

  MultipleTransaction({
    required this.payeeId,
    required this.amount,
  });

  factory MultipleTransaction.fromJson(Map<String, dynamic> json) =>
      MultipleTransaction(
        payeeId: json["payeeId"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "payeeId": payeeId,
        "amount": amount,
      };
}
