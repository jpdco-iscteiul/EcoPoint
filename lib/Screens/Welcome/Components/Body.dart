import 'package:eco_point_app/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the creen
    return Container(
      height: size.height,
      width: double.infinity,
      child: Column(
        children: [
          Container(
          ),
          Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: kContrastColor,
              )
              ],
          ),
        ],
      ),
    );
  }
}
