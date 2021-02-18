import 'package:eco_point_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; // total height and wight of the screen
    return Container(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
              Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 18.0,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto"),
              ),
            ],
          ),
          Image.asset(
            'assets/images/Logo.png',
            //width: 600,
            //height: 240,
            fit: BoxFit.cover,
          ),
          //form(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Nome do utilizador'),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Email do utilizador'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Esqueceu-se da palavra passe?"
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: FlatButton(
                      minWidth: size.width,
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      focusColor: kPrimaryLightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      onPressed: () {
                        /*...*/
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Já possui uma conta?', style: TextStyle(color: Colors.black, fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                            text: " Sign Up",
                            style: TextStyle( color: kPrimaryLightColor)
                          )
                        ]
                      ),
                  ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
