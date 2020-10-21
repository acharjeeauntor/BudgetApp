import 'package:budgetapp/helpers/index.dart';
import 'package:budgetapp/providers/appData.dart';

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
        ChangeNotifierProvider(create: (_) => AppData())
      ],
      child: MaterialApp(
        title: 'Budget App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.orangeAccent,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Merriweather'),
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
