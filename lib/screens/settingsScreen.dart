import 'package:budgetapp/helpers/index.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatefulWidget {
  static const routeName = "setting";

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Welcome To Budget-App",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff474562)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(child: SecondItem()),
            SizedBox(
              height: 20,
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 0.0, top: 4, bottom: 0),
              onTap: () {
                Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
              },
              title: Text('Change Password',
                  style: TextStyle(fontSize: 18.0, color: Color(0Xff5e5e66))),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 0.0, top: 4, bottom: 0),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Alert",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        elevation: 1.8,
                        content: Text("Do you want to Delete Account?"),
                        actions: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                          RaisedButton(
                            onPressed: () {
                              deleteAccount(token: userProvider.authToken);
                            },
                            child: Text("Yes"),
                          )
                        ],
                      );
                    });
              },
              title: Text('Delete Account',
                  style: TextStyle(fontSize: 18.0, color: Color(0Xff5e5e66))),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 0.0, top: 4, bottom: 0),
              onTap: () {
                showShare();
              },
              title: Text('Share',
                  style: TextStyle(fontSize: 18.0, color: Color(0Xff5e5e66))),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 0.0, top: 4, bottom: 0),
              title: Text('App Version 1.0.0',
                  style: TextStyle(fontSize: 18.0, color: Colors.black45)),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 0.0, top: 4, bottom: 0),
              onTap: () {
                //Go to sign in page
                Navigator.of(context).pushReplacementNamed(
                  SigninScreen.routeName,
                );
                //clear SharedPreferences
//                final pref = await SharedPreferences.getInstance();
//                await pref.clear();
              },
              title: Text('Logout',
                  style: TextStyle(fontSize: 18.0, color: Color(0Xff5e5e66))),
            ),
          ],
        ),
      ),
    );
  }

  deleteAccount({token}) async {
    final response = await http.delete(
        'http://10.0.2.2:5000/users/deletemyaccount',
        headers: {"Authorization": "$token"});

    if (response.statusCode == 200) {
      //Clear SharedPreferences
      final pref = await SharedPreferences.getInstance();
      await pref.clear();
      //Navigator to the Signup page
      Navigator.of(context).pushReplacementNamed(
        SignupScreen.routeName,
      );
      Toast.show("Account Delete Successfully", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: const Color(0xff48C9B0));
    } else {
      Toast.show("Some Error Show Please Try Again Later", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: const Color(0xffEC7063));
    }
  }

  Stack SecondItem() {
    return Stack(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/banner.jpg"),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.darken),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
      ],
    );
  }

  void showShare() {
    final RenderBox box = context.findRenderObject();
    Share.share('Share my App:app link',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
