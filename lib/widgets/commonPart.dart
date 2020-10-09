import 'package:budgetapp/helpers/color.dart';
import 'package:flutter/material.dart';

class CommonPart extends StatelessWidget {
  var type;

  CommonPart(this.type);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
                image: AssetImage("assets/images/logo.png")),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "$type",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      width: size.width,
      height: size.height * 0.4,
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80.0))),
    );
  }
}
