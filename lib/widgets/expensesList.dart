import 'package:budgetapp/helpers/index.dart';
import 'package:budgetapp/providers/appData.dart';

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    return Consumer<AppData>(builder: (context, expenses, ch) {
      return expenses.expList.length == 0
          ? Center(child: Text("No Expenses Found!"))
          : ListView.builder(
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
