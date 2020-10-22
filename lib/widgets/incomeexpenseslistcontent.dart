import 'package:budgetapp/helpers/index.dart';

class IncomeExpensesListContent extends StatelessWidget {
  String desc, amount;
  Color clr;

  IncomeExpensesListContent({this.desc, this.amount, this.clr});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: Text(
              desc,
              style: TextStyle(
                  color: clr, fontWeight: FontWeight.w600, fontSize: 17.0),
            ),
            trailing: Text(amount,
                style: TextStyle(
                    color: clr, fontWeight: FontWeight.w600, fontSize: 17.0))),
        Divider(
          height: 5.0,
          color: Colors.black26,
        )
      ],
    );
  }
}
