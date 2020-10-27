import 'package:budgetapp/helpers/index.dart';

class ResetMsgScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Check Your Email"),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SigninScreen.routeName);
              },
              color: containerColor,
              child: const Text(
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
