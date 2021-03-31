import 'dart:collection';
import 'dart:math';

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

  var user;
  var vouchers = null;
  var pointer;
  Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserVouchers();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size; // total height and wight of the screen

    return Scaffold( //tela

      drawer: NavDrawer(), //drawer=menu
      appBar: AppBar( //barra com o titulo
        title: Text('Vouchers Adquiridos'),
        ),
      body: Column(
        children:[ //vetor da coluna
          Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 10), //margin= margem do objeto para fora; padding = moldura do objeto (para dentro)
            height: 50,
            width: 2*size.width/3,
            decoration: BoxDecoration(
              //color: kPrimaryLightColor, //cores estão no constants.dart
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  kPrimaryLightColor,
                  kPrimaryColor,
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child:  Align(
              alignment: Alignment.center,
              child: countVouchers(),
            ),
          ),
          getAllVouchersToShow(pointer),
        ],
      ),
    );
  }


  Future<void> fetchUserVouchers() async {
    user = await ParseUser.currentUser();

    final Map<String, String> params = {
      "user":user.objectId,
    };
    await ParseCloudFunction("getUserVouchers").execute(parameters: params).then((value) =>{
      vouchers = value.result
    });

    setState(() {
      pointer = 0;
    });

    for(final x in vouchers){
      print(x["VoucherId"]["MarcaId"]["Nome"]);
    }
  }

  Widget countVouchers() {
    if (vouchers == null) {
      return CircularProgressIndicator();
    }
    else {
      return Text(
        vouchers.length.toString() + " Vouchers",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Widget getAllVouchersToShow(int p){
    if(pointer == null){
      return   Expanded(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child:CircularProgressIndicator(),
          ),
        ),
      );

    }
    else {
      return   Expanded(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                children:organizeVoucherContainers(p*3)
            ),
          ),
        ),
      );
    }
  }

  List<Widget> organizeVoucherContainers(int i){

    List <Widget> vouchersDesplayed = List<Widget>();
    for(int j=i;j<min(i+3,vouchers.length);j++)
    {
      vouchersDesplayed.add(Voucher_View(j));
    }
    vouchersDesplayed.add(catalogManager());
    return vouchersDesplayed;
  }

  Widget Voucher_View(int i){
    return InkWell(
      child:Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10),
        child: Container( //container dos vouchers
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          margin: EdgeInsets.all(10),
          //height: 120,
          constraints: new BoxConstraints(
            maxHeight: 120,
          ),
          width: 4*size.width/5,
          decoration: BoxDecoration(
              color: Color(int.parse(vouchers[i]["VoucherId"]["MarcaId"]["Cor"])),
              border: Border.all(
                color: kContrastColor,
                width: 2,
              ),
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
                        "Vale " + vouchers[i]["VoucherId"]["Valor"].toString() + "€",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(int.parse(vouchers[i]["VoucherId"]["MarcaId"]["Cor_Letra"])),
                        ),
                      ),
                      Text(
                        vouchers[i]["VoucherId"]["Pontos"].toString() + " pontos",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(int.parse(vouchers[i]["VoucherId"]["MarcaId"]["Cor_Letra"])),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child:Container(
                  child: Image.network(
                    vouchers[i]["VoucherId"]["MarcaId"]["Logo"]["url"],
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        popUp(i);
      },
    );
  }

  Widget catalogManager(){
    if(pointer==null)
      return Container();
    else
      return  Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: size.width/8,
                color: pointer>0 ? kPrimaryColor : Colors.black12,
              ),
              onPressed: () {
                if(pointer>0)
                  setState(() {
                    pointer--;
                  });
              },
            ),
            Text(
              (pointer+1).toString(),
              style: TextStyle(
                fontSize: size.width/10,
              ),
            ),

            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                size: size.width/8,
                color: (pointer+1)*3<vouchers.length ? kPrimaryColor : Colors.black12,
              ),
              onPressed: () {
                if((pointer+1)*3<vouchers.length)
                  setState(() {
                    pointer++;
                  });
              },
            ),
          ],
        ),
      );
  }

  void popUp(int v) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(vouchers[v]["VoucherId"]["MarcaId"]["Nome"]),
          content: Container(
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Valor: "+vouchers[v]["VoucherId"]["Valor"].toString()+"€"),
                Text("Pontos: "+vouchers[v]["VoucherId"]["Pontos"].toString()),
                Text("Descrição: "+vouchers[v]["VoucherId"]["Descricao"]),
                Text("Prazo de Utilização: "+prepareDate( vouchers[v]["VoucherId"]["Data_Expirar"]["iso"]))
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String prepareDate(String text){
    var date = text.replaceRange(10, text.length, '');
    var aux = date.split("-");
    date = aux[2]+"/"+aux[1]+"/"+aux[0];
    return date;
  }
}
