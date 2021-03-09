import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'Welcome/Components/NavDrawer.dart';

class Adquirir_Vouchers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Adquirir_Vouchers_State();
}

class Adquirir_Vouchers_State extends State<Adquirir_Vouchers>{
  List vouch;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 50, 25, 25),
      ),
    );
  }

  void getVouchersAvailable(){
    Map<String, String> parameters = new HashMap<String,String>();

    ParseCloudFunction("getVouchersAvailable").execute(parameters: parameters).then((value) =>{
     print( new List(value.result))

    }
    );
  }

}