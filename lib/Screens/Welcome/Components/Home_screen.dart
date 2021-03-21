import 'dart:io';

import 'package:eco_point_app/Screens/Adquirir_Vouchers.dart';
import 'package:eco_point_app/Screens/Library.dart';
import 'package:eco_point_app/Screens/Welcome/Components/GenerateScreen.dart';
import 'package:eco_point_app/Screens/Welcome/Components/ScanScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../constants.dart';
import 'NavDrawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'QR_Code.dart';

class Home_screen extends StatefulWidget{
  _Home_screen_state createState() => _Home_screen_state();
}

class _Home_screen_state extends State<Home_screen> {
  Future<String> futureData;
  String pontos;

  @override
  void initState() {
    super.initState();
    someMethod();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen

    return Scaffold(

      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 50, 25, 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: loadPoints(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: FlatButton(
                minWidth: size.width,
                color: Color(0XFF616161),
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                focusColor: kPrimaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanScreen()),
                  );
                },

                child: Text(
                  "Read QR code",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: FlatButton(
                minWidth: size.width,
                color: Color(0XFF616161),
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                focusColor: kPrimaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerateScreen()),
                  );
                },

                child: Text(
                  "Generate QR code",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: FlatButton(
                minWidth: size.width,
                color: Color(0XFF616161),
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                focusColor: kPrimaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Adquirir_Vouchers()),
                  );
                },
                child: Text(
                  "Retrieve voucher",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: FlatButton(
                minWidth: size.width,
                color: Color(0XFF616161),
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                focusColor: kPrimaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Library()),
                  );
                },
                child: Text(
                  "Vouchers library",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadPoints(){
    if(pontos == null){
      return CircularProgressIndicator();
    }
    else{
      return Text(
        pontos,
        style: TextStyle(
            color: kPrimaryColor,
            fontSize: 80
        ),
      );
    }
  }

  String someMethod() {
     fetchData().then((s) {
      setState(() {
        pontos=s;
      });
      return s.toString();
    });
  }


  Future<String> fetchData() async {
    var user = await ParseUser.currentUser();
    print(user);

    var queryBuilder = QueryBuilder(ParseObject("Detalhes_Conta"))
                        ..whereEqualTo("UserId", user);
    var response = await queryBuilder.query();
    if(response.success){
      return response.result[0]["Pontos"].toString();
    }
    else{
      return "error";
    }
  }
}

