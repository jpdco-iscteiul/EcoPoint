import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../constants.dart';
import 'Welcome/Components/NavDrawer.dart';

class Library extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Library_State();
// stateful widget - muda de estados
}

class Library_State extends State<Library>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserVouchers();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen

    return Scaffold( //tela

      drawer: NavDrawer(), //drawer=menu
      appBar: AppBar( //barra com o titulo
        title: Text('Biblioteca'),
        ),
    );
  }


  Future<void> fetchUserVouchers() async {
    var user = await ParseUser.currentUser();
    final Map<String, String> params = {
      "user":user.objectId,
    };
    var info;
    await ParseCloudFunction("getUserVouchers").execute(parameters: params).then((value) =>{
      info = value.result
    });

    for(final x in info){
      print(x["VoucherId"]["MarcaId"]["Nome"]);
    }
  }

}
