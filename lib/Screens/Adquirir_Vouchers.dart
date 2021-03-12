import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../constants.dart';
import 'Welcome/Components/NavDrawer.dart';

class Adquirir_Vouchers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Adquirir_Vouchers_State();
}

class Adquirir_Vouchers_State extends State<Adquirir_Vouchers>{
  var marcas;
  var vouchers;
  int pontos=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserPoints();
    getVouchersAvailable();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen

    return Scaffold(

      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Adquirir Vouchers'),
      ),
      body: Column(
        children:[
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            height: 50,
            width: 2*size.width/3,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                pontos.toString()+" Pontos",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            height: 50,
            width: 2*size.width/3,
            decoration: BoxDecoration(
                color: kContrastColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                pontos.toString()+" Pontos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(25, 50, 25, 25),
          ),
        ]
      )

    );
  }

  void getVouchersAvailable() async {
    Map<String, String> parameters = new HashMap<String,String>();

    var info;
     await ParseCloudFunction("getVouchersAvailable").execute(parameters: parameters).then((value) =>{
      //new List(value.result)
     //print(value.result)
      info = value.result
    }
    );
    //print(vouchers);
    setState(() {
      vouchers = info[0];
      marcas = info[1];
    });

    for(final x in marcas){
      print(x["objectId"]);
    }
  }
  void getUserPoints() async {
    var user = await ParseUser.currentUser();
    print(user);

    var queryBuilder = QueryBuilder(ParseObject("Detalhes_Conta"))
      ..whereEqualTo("UserId", user);
    var response = await queryBuilder.query();
    if(response.success){
      setState(pontos = response.result[0]["Pontos"]);
    }
    else{

    }
  }

}
