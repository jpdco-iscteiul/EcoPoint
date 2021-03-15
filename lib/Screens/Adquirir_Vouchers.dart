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
  Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVouchersAvailable(); //devolve um vetor com marcas
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size; // total height and wight of the screen

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
          getAllVouchersToShow(0),
        ]
      )

    );
  }

  void getVouchersAvailable() async {
    getUserPoints();
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

    getCorrectBrand(0);
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

  Container getAllVouchersToShow(int p){

    return Container(
      child: Column(
        children:[Voucher_View(p),
        Voucher_View(p+1),
        Voucher_View(p+2)]
      ),
    );

  }

  Container Voucher_View(int i){
    return Container(
      alignment: Alignment.center,
      child: Container( //container dos vouchers
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        margin: EdgeInsets.all(10),
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
                      "Vale " + vouchers[i]["Valor"].toString() + "€",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      vouchers[i]["Pontos"].toString() + " pontos",
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
                child: Image.network(marcas[getCorrectBrand(i)]["Logo"]["url"]),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  

  int getCorrectBrand(int i){
    int a=0;
    for(final x in marcas){
      if(vouchers[i]["MarcaId"]["objectId"] == x["objectId"]) {
        a = marcas.indexOf(x);
        break;
      }
    }
    return a;
  }

}
