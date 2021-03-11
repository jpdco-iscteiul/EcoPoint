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
  var marcas;
  var vouchers;

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

  Future<void> getVouchersAvailable() async {
    Map<String, String> parameters = new HashMap<String,String>();

    var info;
     await ParseCloudFunction("getVouchersAvailable").execute(parameters: parameters).then((value) =>{
      //new List(value.result)
     //print(value.result)
      info = value.result
    }
    );
    //print(vouchers);
    vouchers = info[0];
    marcas = info[1];
    for(final x in marcas){
      print(x["objectId"]);
    }
  }

}