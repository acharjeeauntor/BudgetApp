import 'package:budgetapp/providers/incomes.dart';
import 'package:budgetapp/providers/user.dart';
import 'package:budgetapp/screens/dashboardScreen.dart';
import 'package:budgetapp/screens/settingsScreen.dart';
import 'package:budgetapp/screens/statemantScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardNavigation extends StatefulWidget {
  static const routeName = 'dashboardnavigation';

  @override
  _DashboardNavigationState createState() => _DashboardNavigationState();
}

class _DashboardNavigationState extends State<DashboardNavigation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userProvider = Provider.of<User>(context, listen: false);
    final incomeProvider = Provider.of<Incomes>(context, listen: false);

    incomeProvider.fetchAndSetAll(token: userProvider.authToken);
  }

  final List<Map<String, Object>> _pages = [
    {'page': DashboardScreen(), 'title': 'Dashboard'},
    {'page': StatementScreen(), 'title': 'Statement'},
    {'page': SettingScreen(), 'title': 'Setting'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          backgroundColor: const Color(0xffF4D03F),
          elevation: 15.0,
          selectedItemColor: Colors.pink,
          selectedFontSize: 15,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('Dashboard')),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_drive_file), title: Text('Statement')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('Setting'))
          ]),
    );
  }
}
