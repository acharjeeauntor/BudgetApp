import 'dart:convert';

import 'package:budgetapp/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DashBoardInputShow extends StatefulWidget {
  @override
  _DashBoardInputShowState createState() => _DashBoardInputShowState();
}

class _DashBoardInputShowState extends State<DashBoardInputShow> {
  @override
  Widget build(BuildContext context) {
    final _descController = TextEditingController();
    final _amountController = TextEditingController();
    var _type = 0;

    final userProvider = Provider.of<User>(context, listen: false);

    void handleSubmit() async {
      if (_type == 0) {
        // post request
        final response = await http.post("http://10.0.2.2:5000/budget/income",
            headers: {"Authorization": "${userProvider.authToken}"},
            body: {"desc": _descController, "amount": _amountController});
        var responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          //notify income list widget

        } else if (response.statusCode == 400) {
          Toast.show(responseData['desc'], context,
              textColor: Colors.white,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.TOP,
              backgroundColor: const Color(0xffEC7063));
        }
      } else if (_type == 1) {
        // post request
        final response = await http.post("http://10.0.2.2:5000/budget/exp",
            headers: {"Authorization": "${userProvider.authToken}"},
            body: {"desc": _descController, "amount": _amountController});
        var responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          //notify income list widget

        } else if (response.statusCode == 400) {
          Toast.show(responseData['desc'], context,
              textColor: Colors.white,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.TOP,
              backgroundColor: const Color(0xffEC7063));
        }
      }
    }

    return Card(
      elevation: 12.0,
      shadowColor: Colors.black,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Description',
                      prefixIcon: Icon(Icons.description)),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Expanded(
                child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Amount',
                      prefixIcon: Icon(Icons.monetization_on)),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToggleSwitch(
                    minWidth: 100.0,
                    fontSize: 15,
                    activeBgColor: Colors.cyan,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    labels: ['Income', 'Expense'],
                    icons: [Icons.add, Icons.remove],
                    onToggle: (index) {
                      //print('switched to: $index');
                      setState(() {
                        _type = index;
                      });
                    },
                  ),
                  IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.arrow_forward),
                      color: Colors.cyan,
                      onPressed: handleSubmit)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
