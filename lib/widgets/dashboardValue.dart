import 'package:budgetapp/helpers/index.dart';
import 'package:budgetapp/providers/incomes.dart';

class DashBoardValueShow extends StatefulWidget {
  @override
  _DashBoardValueShowState createState() => _DashBoardValueShowState();
}

class _DashBoardValueShowState extends State<DashBoardValueShow> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 12.0,
        shadowColor: Colors.black,
        child: Container(
            color: Colors.cyan,
            height: MediaQuery.of(context).size.height * 0.15,
            width: double.infinity,
            child: Consumer<Incomes>(builder: (context, totalValues, ch) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text(
                        "\$ ${totalValues.totalIncome - totalValues.totalExpenses}",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "INCOME:\$",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            totalValues.totalIncome.toString(),
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16.0)),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "EXPENSE:\$",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: totalValues.totalExpenses
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16.0)),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            })),
      ),
    );
  }
}
