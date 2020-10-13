import 'package:budgetapp/widgets/dashboardInput.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DashBoardValueShow(),
            SizedBox(
              height: 5,
            ),
            DashBoardInputShow()
          ],
        ),
      ),
    );
  }
}
