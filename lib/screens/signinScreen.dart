import 'dart:convert';

import 'package:budgetapp/helpers/color.dart';
import 'package:budgetapp/screens/dashboardScreen.dart';
import 'package:budgetapp/screens/resetpasswordScreen.dart';
import 'package:budgetapp/screens/signupScreen.dart';
import 'package:budgetapp/widgets/commonPart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = 'signin';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var formKey = GlobalKey<FormState>();

  var _email, _password;

  void handleSubmit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }

    print(_email);
    print(_password);

    // post request

    final response = await http.post("http://10.0.2.2:5000/users/login",
        body: {"email": _email, "password": _password});

    var responseData = json.decode(response.body);
    print(responseData);

    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed(DashboardScreen.routename);
    } else if (response.statusCode == 404) {
      Toast.show("invalid Email Or Password", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: const Color(0xff8c0000));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: CommonPart("SignIn")),
          Expanded(
            flex: 3,
            child: Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                                  style: TextStyle(color: Colors.grey[600]),
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
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        SignupScreen.routeName,
                                      );
                                    },
                                    child: Text(
                                      "SignUp",
                                      style: TextStyle(
                                          color: containerColor, fontSize: 17),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
