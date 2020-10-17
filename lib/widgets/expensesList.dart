import 'package:budgetapp/providers/incomes.dart';
import 'package:budgetapp/providers/user.dart';
import 'package:budgetapp/widgets/incomeexpenseslistcontent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    return Consumer<Incomes>(builder: (context, expenses, ch) {
      return ListView.builder(
          itemCount: expenses.expList.length,
          itemBuilder: (context, index) {
            return Dismissible(
                direction: DismissDirection.endToStart,
                onDismissed: (DismissDirection direction) async {
                  await expenses
                      .deleteExpenses(
                          id: expenses.expList[index].id,
                          token: userProvider.authToken)
                      .then((_) => setState(() {}));
                },
                key: Key(expenses.expList[index].id),
                background: ListTile(
                  tileColor: Colors.red,
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
                child: IncomeExpensesListContent(
                    desc: expenses.expList[index].desc,
                    amount: expenses.expList[index].amount.toString()));
          });
    });
  }
}
