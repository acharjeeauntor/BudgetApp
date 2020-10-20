import 'package:budgetapp/helpers/index.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = "changepassword";

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var formKey = GlobalKey<FormState>();
  var _comfirmPassword, _oldPassword, _newPassword;
  var passwordCtrl = TextEditingController();
  bool _indicator = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);

    void handleSubmit() async {
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        setState(() {
          _indicator = true;
        });
      }

      // post request

      final response = await http
          .post("http://10.0.2.2:5000/users/changepassword", headers: {
        "Authorization": "${userProvider.authToken}"
      }, body: {
        "oldPassword": _oldPassword,
        "newPassword": _newPassword,
        "confirmPassword": _comfirmPassword
      });

      var responseData = json.decode(response.body);

      // JWT Token get + decode

//    print("Token ${responseData['token']}");
//    Map<String, dynamic> decodedToken =
//        JwtDecoder.decode(responseData['token']);
//    print("Decoded Token $decodedToken");
//    bool hasExpired = JwtDecoder.isExpired(responseData['token']);
//    print("Token validaty$hasExpired");
      if (response.statusCode == 200) {
        //Clear SharedPreferences
        final pref = await SharedPreferences.getInstance();
        await pref.clear();

        setState(() {
          _indicator = false;
        });

        //Navigator to the Signup page
        Navigator.of(context).pushReplacementNamed(
          SigninScreen.routeName,
        );
        Toast.show("Password Change Successfully", context,
            textColor: Colors.red,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
            backgroundColor: const Color(0xff48C9B0));
      } else if (response.statusCode == 401) {
        setState(() {
          _indicator = false;
        });
        Toast.show(responseData['oldPassword'], context,
            textColor: Colors.white,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
            backgroundColor: const Color(0xffEC7063));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: _indicator
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Enter Old Password',
                            prefixIcon: Icon(Icons.lock)),
                        validator: (value) => value.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                        onSaved: (value) => _oldPassword = value,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordCtrl,
                        decoration: InputDecoration(
                            labelText: 'Enter New Password',
                            prefixIcon: Icon(Icons.lock)),
                        validator: (value) => value.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                        onSaved: (value) => _newPassword = value,
                      ),
                      TextFormField(
                        obscureText: true,
                        //controller: confPasswordCtrl,
                        decoration: InputDecoration(
                            labelText: 'Re-enter Password',
                            prefixIcon: Icon(Icons.lock)),
                        validator: (value) => value != passwordCtrl.text
                            ? "Password Not match"
                            : null,
                        onSaved: (value) => _comfirmPassword = value,
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
                            "Change Password",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
