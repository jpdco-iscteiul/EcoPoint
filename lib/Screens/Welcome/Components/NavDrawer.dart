import 'dart:collection';

import 'package:eco_point_app/Screens/Adquirir_Vouchers.dart';
import 'package:eco_point_app/Screens/Library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../constants.dart';
import 'Home_screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: kContrastColor,
                image: DecorationImage(
                    //fit: BoxFit.cover,
                    image: AssetImage('assets/images/Logo.png'))),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home_screen()),
            )
            },

          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.restore_from_trash),
            title: Text('Registar pesagem'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.library_add),
            title: Text('Adquirir vouchers'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Adquirir_Vouchers()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.list_alt_rounded),
            title: Text('Vouchers Adquiridos'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Library()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.timelapse_outlined),
            title: Text('Histórico'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}