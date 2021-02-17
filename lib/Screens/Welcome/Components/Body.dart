import 'package:eco_point_app/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen
    return Container(
      padding: EdgeInsets.fromLTRB(25, 35, 25, 35),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                  size: 30
              ),
              Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 18.0,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
            ],
          ),
          Image.asset(
            'assets/images/Logo.png',
            //width: 600,
           // height: 240,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your username'
              ),
            ),
          ),

        ],
      ),
    );
  }
}