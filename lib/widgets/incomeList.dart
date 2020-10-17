import 'package:budgetapp/providers/incomes.dart';
import 'package:budgetapp/providers/user.dart';
import 'package:budgetapp/widgets/incomeexpenseslistcontent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeList extends StatefulWidget {
  @override
  _IncomeListState createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    return Consumer<Incomes>(
      builder: (context, incomes, ch) {
        return ListView.builder(
            itemCount: incomes.incList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  direction: DismissDirection.startToEnd,
                  onDismissed: (DismissDirection direction) async {
                    await incomes
                        .deleteIncome(
                            id: incomes.incList[index].id,
                            token: userProvider.authToken)
                        .then((_) => setState(() {}));
                  },
                  key: UniqueKey(),
                  background: ListTile(
                    tileColor: Colors.red,
                    leading: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                  child: IncomeExpensesListContent(
                      desc: incomes.incList[index].desc,
                      amount: incomes.incList[index].amount.toString()));
            });
      },
    );
  }
}
