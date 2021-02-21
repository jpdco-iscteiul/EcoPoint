import 'package:eco_point_app/Screens/Create_account_screen.dart';
import 'package:eco_point_app/Screens/Welcome/Welcome_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import '../constants.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';


class Log_in_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen
    // TODO: implement build
    return Scaffold(
        body:
        Container(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
          //color : Colors.black,
          child: Column(
            children: [
              Image.asset(
                'assets/images/Logo_s_texto.png',
                width: 500,
                height: 240,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  Text(
                    "Bem-vindo(a)!",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto"),
                  ),
                  Text(
                    "Inicie sessão para começar a utilizar a aplicação!",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Roboto"),
                  ),
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
                        //createAccount();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {},
                  ),
                   SignInButton(
                    Buttons.Facebook,
                    text: "Sign up with Facebook",
                    onPressed: () {},
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Não possui conta?',
                        style: TextStyle(
                            color: Colors.black, fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                              text: " Sign up",
                              style: TextStyle(color: kPrimaryLightColor),
                              recognizer: new TapGestureRecognizer()..onTap = () => navigateToSignUpPage(context)
                          )
                        ]
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
    throw UnimplementedError();
  }

  navigateToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Create_account_screen()),
    );
  }

}
