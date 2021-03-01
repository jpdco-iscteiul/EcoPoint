import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../constants.dart';
import 'NavDrawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home_screen extends StatefulWidget{
  _Home_screen_state createState() => _Home_screen_state();
}

class _Home_screen_state extends State<Home_screen> {
  Future<String> futureData;
  String pontos;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(); // Here you have the data that you need
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen
    someMethod();

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
              child: Text(
                '' +  pontos,
                style: TextStyle(
                    color: kPrimaryColor,
                      fontSize: 80
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
                  //TODO
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
                  //TODO
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
                  //TODO
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


  String someMethod() {
    fetchData().then((s) {
      pontos=s;
      return s.toString();
    });
  }


  Future<String> fetchData() async {
    //var currentUser = ParseUser.currentUser().toString();
    final detalhes = await ParseObject("Detalhes_Conta").getObject("2mKs0ADVXt");
    final objeto = await detalhes.result['Pontos'].toString();
    return objeto;
    }
}

