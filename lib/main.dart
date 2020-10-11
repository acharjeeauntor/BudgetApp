import 'package:budgetapp/screens/dashboardScreen.dart';
import 'package:budgetapp/screens/signinScreen.dart';
import 'package:budgetapp/screens/signupScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SigninScreen.routeName,
      routes: {
        SignupScreen.routeName: (ctx) => SignupScreen(),
        SigninScreen.routeName: (ctx) => SigninScreen(),
        DashboardScreen.routename:(ctx)=>DashboardScreen()
      },
    );
  }
}
