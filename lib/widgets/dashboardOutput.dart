import 'package:budgetapp/helpers/index.dart';

class DashBoardOutput extends StatefulWidget {
  @override
  _DashBoardOutputState createState() => _DashBoardOutputState();
}

class _DashBoardOutputState extends State<DashBoardOutput> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: new Container(
            color: Colors.cyan,
            child: new SafeArea(
              child: TabBar(tabs: [
                Tab(
                  text: 'INCOME',
                ),
                Tab(
                  text: 'EXPENSES',
                ),
              ]),
            ),
          ),
        ),
        body: TabBarView(
          children: [IncomeList(), ExpensesList()],
        ),
      ),
    );
  }
}
