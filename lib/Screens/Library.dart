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
  var vouchers;
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
        title: Text('Biblioteca'),
        ),
      body: Column(
        children:[ //vetor da coluna
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
                        "Vale " + vouchers[i]["VoucherId"]["Valor"].toString() + "€",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        vouchers[i]["VoucherId"]["Pontos"].toString() + " pontos",
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
        //popUp(i, getCorrectBrand(i));
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
          mainAxisAlignment: MainAxisAlignment.end,
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

}
