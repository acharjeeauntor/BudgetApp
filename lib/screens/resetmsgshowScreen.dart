import 'package:budgetapp/helpers/color.dart';
import 'package:budgetapp/screens/signinScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetMsgScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Check Your Email"),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SigninScreen.routeName);
              },
              color: containerColor,
              child: Text(
                "SignIn",
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}