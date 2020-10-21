import 'package:budgetapp/helpers/index.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  static const routeName = 'signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _indicator = false;

  var formKey = GlobalKey<FormState>();

  var _email, _password, _name, _confPassword;
  var passwordCtrl = TextEditingController();

  void handleSubmit() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setState(() {
        _indicator = true;
      });
    }

    // post request

    Map<String, dynamic> data = {
      'name': _name,
      'email': _email,
      'password': _password,
      'password2': _confPassword
    };

    final response = await http.post('http://10.0.2.2:5000/users/register',
        headers: {"content-Type": "application/json;charset=utf-8"},
        body: json.encode(data));
    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        this._email = '';
        this._password = '';
        this._name = '';
        this._confPassword = '';
        this._indicator = false;
      });
      Navigator.of(context).pushReplacementNamed(
        SigninScreen.routeName,
      );
    } else if (responseData['email'].toString().isNotEmpty) {
//      Fluttertoast.showToast(
//          msg: "abc",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 16.0);
      setState(() {
        _indicator = false;
      });
      Toast.show(responseData['email'].toString(), context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: const Color(0xff8c0000));
    }
  }

  @override
  Widget build(BuildContext context) {
//    var MQ = MediaQuery.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: _indicator
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonPart("SignUp"),
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
                                  //controller: nameCtrl,
                                  decoration: InputDecoration(
                                      labelText: 'Enter Your Name',
                                      prefixIcon: Icon(Icons.face)),
                                  validator: (value) =>
                                      value.isEmpty ? "Name is required" : null,
                                  onSaved: (value) => _name = value,
                                ),
                                TextFormField(
                                  //controller: emailCtrl,
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
                                  controller: passwordCtrl,
                                  decoration: InputDecoration(
                                      labelText: 'Enter Your Password',
                                      prefixIcon: Icon(Icons.lock)),
                                  validator: (value) => value.length < 6
                                      ? "Password must be at least 6 characters"
                                      : null,
                                  onSaved: (value) => _password = value,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  //controller: confPasswordCtrl,
                                  decoration: InputDecoration(
                                      labelText: 'Re-enter Password',
                                      prefixIcon: Icon(Icons.lock)),
                                  validator: (value) =>
                                      value != passwordCtrl.text
                                          ? "Password Not match"
                                          : null,
                                  onSaved: (value) => _confPassword = value,
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
                                      "SignUp",
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
                                        "Already a member?",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              SigninScreen.routeName,
                                            );
                                          },
                                          child: Text(
                                            "SignIn",
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
                  ],
                ),
              ),
            ),
    );
  }
}
