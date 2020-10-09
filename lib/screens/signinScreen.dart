import 'package:budgetapp/helpers/color.dart';
import 'package:budgetapp/screens/signupScreen.dart';
import 'package:budgetapp/widgets/commonPart.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = 'signin';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var formKey = GlobalKey<FormState>();

  var email, password;
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  void handleSubmit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }

    print(email);
    print(password);

    // post request
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              CommonPart("SignIn"),
              Container(
                width: size.width,
                height: size.height * 0.6,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailCtrl,
                              decoration: InputDecoration(
                                  labelText: 'Enter Your Email',
                                  prefixIcon: Icon(Icons.mail)),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (!value.contains("@")) {
                                  "please Give a valid Email Address";
                                }
                              },
                              onSaved: (value) {
                                this.email = value;
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordCtrl,
                              decoration: InputDecoration(
                                  labelText: 'Enter Your Password',
                                  prefixIcon: Icon(Icons.lock)),
                              validator: (value) {
                                if (value.length < 6)
                                  return ("Password at least 6 Character");
                              },
                              onSaved: (value) {
                                this.password = value;
                              },
                            ),
                            GestureDetector(
                              onTap: null,
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
                              margin: EdgeInsets.only(top: 40),
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
                                            color: containerColor,
                                            fontSize: 17),
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
            ],
          ),
        ],
      ),
    );
  }
}
