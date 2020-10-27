import 'package:budgetapp/helpers/index.dart';
import 'package:budgetapp/providers/appData.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  static const routename = 'dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    final appDataProvider = Provider.of<AppData>(context, listen: false);

    Future<Null> refresh() async {
      // print("Refresh Called");
      await appDataProvider.fetchAndSetAll(token: userProvider.authToken);
      return null;
    }

    return Scaffold(
        body: RefreshIndicator(
      key: refreshKey,
      onRefresh: () async {
        await refresh();
      },
      child: Column(
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
      ),
    ));
  }
}
