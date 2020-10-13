import 'package:flutter/material.dart';

class DashBoardValueShow extends StatefulWidget {
  @override
  _DashBoardValueShowState createState() => _DashBoardValueShowState();
}

class _DashBoardValueShowState extends State<DashBoardValueShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total:Total",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "income:income",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Text(
                "Expenses:Expenses",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
