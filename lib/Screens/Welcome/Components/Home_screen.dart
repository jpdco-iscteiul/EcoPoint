import 'dart:io';

import 'package:eco_point_app/Screens/Adquirir_Vouchers.dart';
import 'package:eco_point_app/Screens/Library.dart';
import 'package:eco_point_app/Screens/Welcome/Components/GenerateScreen.dart';
import 'package:eco_point_app/Screens/Welcome/Components/ScanScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  var user;

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
        padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
        child: Column(
          children: [
            Container(
              child: Image.asset(
                'assets/images/Logo_texto.png',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: greetings(),
            ),
            Align(
              alignment: Alignment.center,
              child: loadPoints(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: FlatButton(
                minWidth: size.width,
                height: 50,
                color: Color(0XFF616161),
                highlightColor: kPrimaryLightColor,
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
                  "Ler QR code",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: FlatButton(
                minWidth: size.width,
                height: 50,
                color: Color(0XFF616161),
                highlightColor: kPrimaryLightColor,
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
                  "Gerar QR code",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: FlatButton(
                minWidth: size.width,
                height: 50,
                color: Color(0XFF616161),
                highlightColor: kPrimaryLightColor,
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
                  "Adquirir vouchers",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: FlatButton(
                minWidth: size.width,
                height: 50,
                color: Color(0XFF616161),
                highlightColor: kPrimaryLightColor,
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
                  "Vouchers adquiridos",
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
      return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
            width: 2
          ), 
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Text(
          pontos+" Pontos",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 35
          ),
        ),
      );
    }
  }

  Widget greetings(){
    if(user == null){
      return CircularProgressIndicator();
    }
    else{
      return RichText(
        text: TextSpan(
            text: 'Bem vindo de volta ',
            style: TextStyle(
                color: kContrastColor, fontSize: 20),
            children: <TextSpan>[
              TextSpan(
                text: user["Name"],
                style: TextStyle(color: kPrimaryColor, fontSize: 20),
              )
            ]
        ),
      );

        /*Text(
        "Bem vindo de volta "+user["Name"],
        style: TextStyle(
            color: kPrimaryColor,
            fontSize: 20
        ),
      );*/
    }
  }

  String someMethod() {
     fetchData().then((s) {
      setState(() {
        user = getUser();
        pontos=s;
      });
      return s.toString();
    });
  }

  ParseUser getUser(){
    return user;
  }


  Future<String> fetchData() async {
    user = await ParseUser.currentUser();

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

