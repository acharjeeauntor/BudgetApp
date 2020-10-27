//import 'package:budgetapp/helpers/index.dart';
//import 'package:budgetapp/widgets/bouncypageroute.dart';
//import 'package:flutter/material.dart';
//
//class SplashScreen extends StatefulWidget {
//  static const routeName = "splashScreen";
//
//  @override
//  _SplashScreenState createState() => _SplashScreenState();
//}
//
//class _SplashScreenState extends State<SplashScreen> {
//  Future<String> getValue() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    //Return String
//    String stringValue = prefs.getString('tokenkey');
//    return stringValue;
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final userProvider = Provider.of<User>(context);
//    getValue().then((value) {
//      print("value:$value");
//      if (value != null) {
//        userProvider.addToken = value;
//        Navigator.pushReplacement(
//            context,
//            BouncyPageRoute(
//                widget: DashboardNavigation(), crv: Curves.easeInOut));
//      } else {
//        Navigator.pushReplacement(context,
//            BouncyPageRoute(widget: SigninScreen(), crv: Curves.easeInBack));
//      }
//    });
//
//    Size size = MediaQuery.of(context).size;
//    return Scaffold(
//      body: Center(
//        child: Container(
//          width: size.width * 0.4,
//          height: size.height * 0.4,
//          child: Image(image: AssetImage("assets/images/logo.png")),
//        ),
//      ),
//    );
//  }
//}
