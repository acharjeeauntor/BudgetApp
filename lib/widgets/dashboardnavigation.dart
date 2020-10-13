import 'package:budgetapp/screens/dashboardScreen.dart';
import 'package:budgetapp/screens/settingsScreen.dart';
import 'package:budgetapp/screens/statemantScreen.dart';
import 'package:flutter/material.dart';

class DashboardNavigation extends StatefulWidget {
  static const routeName = 'dashboardnavigation';

  @override
  _DashboardNavigationState createState() => _DashboardNavigationState();
}

class _DashboardNavigationState extends State<DashboardNavigation> {
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
                icon: Icon(Icons.settings), title: Text('Statement')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('Setting'))
          ]),
    );
  }
}
