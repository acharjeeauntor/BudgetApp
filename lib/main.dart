import 'package:budgetapp/providers/incomes.dart';
import 'package:budgetapp/screens/changePasswordScreen.dart';
import 'package:budgetapp/screens/dashboardScreen.dart';
import 'package:budgetapp/screens/settingsScreen.dart';
import 'package:budgetapp/screens/signinScreen.dart';
import 'package:budgetapp/screens/signupScreen.dart';
import 'package:budgetapp/widgets/dashboardnavigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => Incomes())
      ],
      child: MaterialApp(
        title: 'Budget App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.orangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        //initialRoute: DashboardNavigation.routeName,
        initialRoute: SigninScreen.routeName,
        routes: {
          SignupScreen.routeName: (ctx) => SignupScreen(),
          SigninScreen.routeName: (ctx) => SigninScreen(),
          DashboardScreen.routename: (ctx) => DashboardScreen(),
          DashboardNavigation.routeName: (ctx) => DashboardNavigation(),
          SettingScreen.routeName: (ctx) => SettingScreen(),
          ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen()
        },
      ),
    );
  }
}
