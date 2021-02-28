import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home_screen extends StatefulWidget{
  _Home_screen_state createState() => _Home_screen_state();
}

class _Home_screen_state extends State<Home_screen> {
  Future<String> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(); // Here you have the data that you need
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: new SingleChildScrollView(
          child: FutureBuilder<String>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),

    );

  }




  Future<String> fetchData() async {
    final response = await http.get(
        'https://parseapi.back4app.com/classes/Detalhes_Conta/2mKs0ADVXt?keys=Pontos',
        headers: {
          "X-Parse-Application-Id": "2Uo1ieG4kQ6FGVJscXUDDibO4wZRz9R12nQ2GBji", // This is your app's application id
          "X-Parse-REST-API-Key": "VJDoTdA2akw815PPzKNkU2M9ORleHsDoMc9diXsN" // This is your app's REST API key
        }
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return (responseJson['Pontos']);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

}


