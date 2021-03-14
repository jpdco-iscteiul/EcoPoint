import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../constants.dart';
import 'Welcome/Components/NavDrawer.dart';

class Adquirir_Vouchers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Adquirir_Vouchers_State();
  // stateful widget - muda de estados
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
    getVouchersAvailable(); //devolve um vetor com marcas
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen

    return Scaffold( //tela

      drawer: NavDrawer(), //drawer=menu
      appBar: AppBar( //barra com o titulo
        title: Text('Adquirir Vouchers'),
      ),
      body: Column(
        children:[ //vetor da coluna
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20), //margin= margem do objeto para fora; padding = moldura do objeto (para dentro)
            height: 50,
            width: 2*size.width/3,
            decoration: BoxDecoration(
              color: kPrimaryLightColor, //cores estão no constants.dart
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
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
            alignment: Alignment.center,
            child: Container( //container dos vouchers
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              height: 150,
              width: 4*size.width/5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child:Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         Text(
                          "Vale " + vouchers[0]["Valor"].toString() + "€",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          vouchers[0]["Pontos"].toString() + " pontos",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                     ),
                    ),
                  ),
                    Expanded(
                      flex: 6,
                      child:Container(
                        child: Image.network(marcas[2]["Logo"]["url"]),
                      ),
                    ),
                ],
              ),
            ),
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
    setState(() { //povoamento dos vetores; marcas e vouchers ganham informação
      vouchers = info[0];
      marcas = info[1];
    });

    for(final x in marcas){
      print(x["Logo"]["url"]);
    }
  }
  void getUserPoints() async {
    var user = await ParseUser.currentUser(); // await= garante que so passo para a proxima linha depois deste procedimento acabar


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
