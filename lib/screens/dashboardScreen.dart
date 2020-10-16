import 'package:budgetapp/widgets/dashboardInput.dart';
import 'package:budgetapp/widgets/dashboardOutput.dart';
import 'package:budgetapp/widgets/dashboardValue.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static const routename = 'dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: DashBoardValueShow(),
            )),
        Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6.0),
              child: DashBoardInputShow(),
            )),
        Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: DashBoardOutput(),
            ))
      ],
    ));
  }
}
