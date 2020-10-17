// To parse this JSON data, do
//
//     final income = incomeFromJson(jsonString);

import 'dart:convert';

List<Income> incomeFromJson(String str) =>
    List<Income>.from(json.decode(str).map((x) => Income.fromJson(x)));

String incomeToJson(List<Income> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Income {
  Income({
    this.amount,
    this.id,
    this.user,
    this.desc,
    this.date,
    this.v,
  });

  int amount;
  String id;
  User user;
  String desc;
  DateTime date;
  int v;

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        amount: json["amount"],
        id: json["_id"],
        user: userValues.map[json["user"]],
        desc: json["desc"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "_id": id,
        "user": userValues.reverse[user],
        "desc": desc,
        "date": date.toIso8601String(),
        "__v": v,
      };
}

enum User { THE_5_F849_E30_CEFC9_D11_AC5197_D6 }

final userValues = EnumValues(
    {"5f849e30cefc9d11ac5197d6": User.THE_5_F849_E30_CEFC9_D11_AC5197_D6});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
