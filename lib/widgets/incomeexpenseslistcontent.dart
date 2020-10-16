import 'package:flutter/material.dart';

class IncomeExpensesListContent extends StatelessWidget {
  String desc, amount;

  IncomeExpensesListContent({this.desc, this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: Text(desc), trailing: Text(amount)),
        Divider(
          height: 5.0,
          color: Colors.black26,
        )
      ],
    );
  }
}
