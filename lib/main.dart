import 'package:eco_point_app/Screens/Create_account_screen.dart';

import 'Screens/Welcome/Welcome_screen.dart';
import 'package:eco_point_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(kParseApplicationId, kUrl,
  clientKey: kParseClientKey, masterKey: kParseMasterKey, debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: "EcoPoint",
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Create_account_screen(),
    );
  }

}



