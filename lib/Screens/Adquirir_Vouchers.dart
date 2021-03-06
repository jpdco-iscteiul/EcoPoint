import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../constants.dart';
import 'Welcome/Components/NavDrawer.dart';

// ignore: camel_case_types
class Adquirir_Vouchers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Adquirir_Vouchers_State();
  // stateful widget - muda de estados
}

class Adquirir_Vouchers_State extends State<Adquirir_Vouchers>{

  var user;
  var marcas;
  var vouchers;
  int pontos;
  Size size;
  int pointer;

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
      //backgroundColor: kContrastLighterColor,
      body: Column(
        children:[ //vetor da coluna
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20), //margin= margem do objeto para fora; padding = moldura do objeto (para dentro)
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
              child: loadPoints(),
            ),
          ),
          getAllVouchersToShow(pointer),
        ],
      ),

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
      pointer = 0;
    });
  }
  void getUserPoints() async {
    user = await ParseUser.currentUser(); // await= garante que so passo para a proxima linha depois deste procedimento acabar

    setState(() {
      pontos = null;
    });

    var queryBuilder = QueryBuilder(ParseObject("Detalhes_Conta"))
      ..whereEqualTo("UserId", user);
    var response = await queryBuilder.query();
    if(response.success){
      setState((){
        pontos = response.result[0]["Pontos"];
      });
    }
    else{

    }
  }

  void acquireVoucher(var voucherId) async {
      final Map<String, String> params = {
        "user":user.objectId,
        "voucher": voucherId
      };

      var result = await ParseCloudFunction("acquireVoucher").execute(parameters: params);

      if(result.success){
        print(result.result);
        getUserPoints();
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

    List <Widget> tripleVouchersDisplayed = List<Widget>();
    for(int j=i;j<min(i+3,vouchers.length);j++)
    {
      tripleVouchersDisplayed.add(Voucher_View(j));
    }
    tripleVouchersDisplayed.add(catalogManager());
    return tripleVouchersDisplayed;
  }

  // ignore: non_constant_identifier_names
  Widget Voucher_View(int i){
    return InkWell(
      child:Container(
        alignment: Alignment.center,
        child: Container( //container dos vouchers
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          margin: EdgeInsets.all(10),
          //height: 120,
          constraints: new BoxConstraints(
            maxHeight: 120,
          ),
          width: 4*size.width/5,
          decoration: BoxDecoration(
              color: Color(int.parse(marcas[getCorrectBrand(i)]["Cor"])),
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
                        "Vale " + vouchers[i]["Valor"].toString() + "€",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(int.parse(marcas[getCorrectBrand(i)]["Cor_Letra"])),
                        ),
                      ),
                      Text(
                        vouchers[i]["Pontos"].toString() + " pontos",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(int.parse(marcas[getCorrectBrand(i)]["Cor_Letra"])),
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
                    marcas[getCorrectBrand(i)]["Logo"]["url"],
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        popUp(i, getCorrectBrand(i));
      },
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

  Widget loadPoints() {
    if (pontos == null) {
      return CircularProgressIndicator();
    }
    else {
      return Text(
        pontos.toString() + " Pontos",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      );
    }
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

  void popUp(int v, int m) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pretende adquiri este voucher?"),
          content: Container(
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Valor: "+vouchers[v]["Valor"].toString()+"€"),
                Text("Pontos: "+vouchers[v]["Pontos"].toString()),
                Text("Descrição: "+vouchers[v]["Descricao"]),
                Text("Marca: "+marcas[m]["Nome"]),
                Text("Prazo de Utilização: "+prepareDate(vouchers[m]["Data_Expirar"]["iso"]))
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
            FlatButton(
              child: const Text("Adquirir"),
              onPressed: () {
                acquireVoucher(vouchers[v]["objectId"]);
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
