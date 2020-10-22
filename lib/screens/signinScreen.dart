import 'dart:convert';

import 'package:budgetapp/helpers/color.dart';
import 'package:budgetapp/helpers/index.dart';
import 'package:budgetapp/providers/user.dart';
import 'package:budgetapp/screens/resetpasswordScreen.dart';
import 'package:budgetapp/screens/signupScreen.dart';
import 'package:budgetapp/widgets/bouncypageroute.dart';
import 'package:budgetapp/widgets/commonPart.dart';
import 'package:budgetapp/widgets/dashboardnavigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = 'signin';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _indicator = false;

  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    final token = getStringValuesSF();
//    if (token != null) {
//      Provider.of<User>(context, listen: false).addToken = token.toString();
//      Navigator.of(context).pushReplacementNamed(DashboardNavigation.routeName);
//    } else {
//      return;
//    }
//  }

  var formKey = GlobalKey<FormState>();

  var _email, _password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userProvider = Provider.of<User>(context, listen: false);

    void handleSubmit() async {
      FocusScope.of(context).unfocus();
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        setState(() {
          _indicator = true;
        });
      }

      print(_email);
      print(_password);

      // post request

      final response = await http.post("http://10.0.2.2:5000/users/login",
          body: {"email": _email, "password": _password});

      var responseData = json.decode(response.body);

      // JWT Token get + decode

//    print("Token ${responseData['token']}");
//    Map<String, dynamic> decodedToken =
//        JwtDecoder.decode(responseData['token']);
//    print("Decoded Token $decodedToken");
//    bool hasExpired = JwtDecoder.isExpired(responseData['token']);
//    print("Token validaty$hasExpired");

      if (response.statusCode == 200) {
        addStringToSF(responseData['token']);
        userProvider.addToken = responseData['token'];
        setState(() {
          _indicator = false;
        });

        //Page Route Builder
        Navigator.pushReplacement(
            context, BouncyPageRoute(widget: DashboardNavigation(),crv: Curves.easeInOut));
      } else if (response.statusCode == 404) {
        setState(() {
          _indicator = false;
        });
        Toast.show("invalid Email Or Password", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
            backgroundColor: const Color(0xffEC7063));
      }
    }

    return Scaffold(
      body: _indicator
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonPart("SignIn"),
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Enter Your Email',
                                      prefixIcon: Icon(Icons.mail)),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => !value.contains("@")
                                      ? "Enter a valid email"
                                      : null,
                                  onSaved: (value) => _email = value,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Enter Your Password',
                                      prefixIcon: Icon(Icons.lock)),
                                  validator: (value) => value.length < 6
                                      ? "Password at least 6 Character"
                                      : null,
                                  onSaved: (value) => _password = value,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetPasswordScreen()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: 10, top: 10, bottom: 10),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "Forget Password?",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    color: containerColor,
                                    onPressed: handleSubmit,
                                    child: Text(
                                      "SignIn",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account?",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context, BouncyPageRoute(widget: SignupScreen(),crv: Curves.linearToEaseOut));
                                          },
                                          child: Text(
                                            "SignUp",
                                            style: TextStyle(
                                                color: containerColor,
                                                fontSize: 17),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                          icon: FaIcon(
                                              FontAwesomeIcons.googlePlusG),
                                          iconSize: 40,
                                          color: Colors.redAccent,
                                          onPressed: () {
                                            print("Pressed");
                                          }),
                                      IconButton(
                                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                          icon:
                                              FaIcon(FontAwesomeIcons.facebook),
                                          iconSize: 40,
                                          color: Colors.blueAccent,
                                          onPressed: () {
                                            print("Pressed");
                                          }),
                                      IconButton(
                                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                          icon:
                                              FaIcon(FontAwesomeIcons.linkedin),
                                          iconSize: 40,
                                          color: Colors.teal,
                                          onPressed: () {
                                            print("Pressed");
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

addStringToSF(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(token, "jwtToken");
}

//getStringValuesSF() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  //Return String
//  String stringValue = prefs.getString('jwtToken');
//  return stringValue;
//}
