import 'package:budgetapp/helpers/index.dart';
import 'package:budgetapp/providers/incomes.dart';

class DashboardScreen extends StatefulWidget {
  static const routename = 'dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    final appDataProvider = Provider.of<Incomes>(context, listen: false);

//    Future<Null> refresh() async {
//      print("Refresh Called");
//      await appDataProvider.fetchAndSetAll(token: userProvider.authToken);
//    }

    return Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DashBoardValueShow(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6.0),
                child: DashBoardInputShow(),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DashBoardOutput(),
              ),
            )
          ],
        ));
  }
}
