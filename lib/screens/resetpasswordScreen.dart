import 'package:budgetapp/helpers/index.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var formKey = GlobalKey<FormState>();
  var _email;
  bool _indicator = false;

  void handleSubmit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setState(() {
        _indicator = true;
      });
    }


    final response = await http.post("http://10.0.2.2:5000/users/resetpassword",
        body: {"email": _email});

    var responseData = json.decode(response.body);
    print(responseData);

    if (response.statusCode == 200) {
      setState(() {
        _indicator = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResetMsgScreen()));
    } else if (response.statusCode == 404) {
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
    return Scaffold(
        body: _indicator
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Enter Your Email',
                            prefixIcon: Icon(Icons.mail)),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            !value.contains("@") ? "Enter a valid email" : null,
                        onSaved: (value) => _email = value,
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
                            "Reset Password",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
