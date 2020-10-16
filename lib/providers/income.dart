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
  String user;
  String desc;
  DateTime date;
  int v;

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        amount: json["amount"],
        id: json["_id"],
        user: json["user"],
        desc: json["desc"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "_id": id,
        "user": user,
        "desc": desc,
        "date": date.toIso8601String(),
        "__v": v,
      };
}
