import 'package:budgetapp/helpers/color.dart';
import 'package:flutter/material.dart';

class DashBoardInputShow extends StatefulWidget {
  @override
  _DashBoardInputShowState createState() => _DashBoardInputShowState();
}

class _DashBoardInputShowState extends State<DashBoardInputShow> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
//        boxShadow: [
//          BoxShadow(
//            color: Colors.grey.withOpacity(0.5),
//            spreadRadius: 5,
//            blurRadius: 7,
//            offset: Offset(0, 3), // changes position of shadow
//          ),
//        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter Your Email', prefixIcon: Icon(Icons.mail)),
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  !value.contains("@") ? "Enter a valid email" : null,
              onSaved: (value) {},
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Enter Your Password',
                  prefixIcon: Icon(Icons.lock)),
              validator: (value) =>
                  value.length < 6 ? "Password at least 6 Character" : null,
              onSaved: (value) {},
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: containerColor,
                onPressed: null,
                child: Text(
                  "SignIn",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
