import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DashBoardValueShow extends StatefulWidget {
  @override
  _DashBoardValueShowState createState() => _DashBoardValueShowState();
}

class _DashBoardValueShowState extends State<DashBoardValueShow> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shadowColor: Colors.black,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Totalkjhghghgh",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            VerticalDivider(
              color: Colors.grey,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: "INCOME:\$",
                            style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "150",
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 16.0)),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: "EXPENSE:\$",
                            style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "150",
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 16.0)),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
