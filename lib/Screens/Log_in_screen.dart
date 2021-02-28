import 'package:eco_point_app/Screens/Create_account_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../constants.dart';
import 'Welcome/Components/Home_screen.dart';


class Log_in_screen extends StatefulWidget{
    _Log_in_state createState() => _Log_in_state();
}

class _Log_in_state extends State<Log_in_screen> {

  final controlUsername = TextEditingController();
  final controlPassword = TextEditingController();

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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children:[
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                controller: controlUsername,
                                decoration:
                                InputDecoration(labelText: 'Nome do utilizador'),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                controller: controlPassword,
                                obscureText: true,
                                decoration:
                                InputDecoration(labelText: 'Password'),
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
                                  LogIn();
                                },
                                child: Text(
                                  "Log In",
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
                              onPressed: () {
                                test();
                              },
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
                          ]
                      ),
                    ),
                  ),

                ],
              ),

        )
    );
    throw UnimplementedError();
  }

  Future<void> test() async {
    print(await ParseUser.currentUser());
  }
  navigateToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Create_account_screen()),
    );
  }


  void showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: const Text("User was successfully created!"),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void LogIn() async {
    final username = controlUsername.text.trim();
    final password = controlPassword.text.trim();


    final user = ParseUser.createUser(username, password);
    var response = await user.login();

    if (response.success) {
      ParseUser useraux = await ParseUser.currentUser();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home_screen()),
      );
      } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Log_in_screen()),
      );
      showError(response.error.message);
    }
  }


}
