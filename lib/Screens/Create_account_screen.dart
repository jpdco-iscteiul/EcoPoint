import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'Log_in_screen.dart';
import '../constants.dart';

// ignore: camel_case_types
class Create_account_screen extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<Create_account_screen> {

  final controlUsername = TextEditingController();
  final controlEmail = TextEditingController();
  final controlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // total height and wight of the screen
    return Scaffold(
        body:
        Container(
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
                        controller: controlUsername,
                        decoration:
                        InputDecoration(labelText: 'Nome do utilizador'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextFormField(
                        controller: controlEmail,
                        decoration:
                        InputDecoration(labelText: 'Email do utilizador'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: TextField(
                        controller: controlPassword,
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
                          createAccount();
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
                              text: 'Já possui uma conta?',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " Log In",
                                    style: TextStyle(color: kPrimaryLightColor),
                                    recognizer: new TapGestureRecognizer()..onTap = () => navigateToLogInPage(context)
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
        )
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

  Future<void> createProfile(ParseUser user) async {
    final profile = ParseObject('Detalhes_Conta')..set('UserId', user);
    var response = await profile.save();

    if(response.success){
        user..set('Conta_Id', profile);
        final response2 = await user.update();
    }
    else{

    }
  }

  void createAccount() async {

    final username = controlUsername.text.trim();
    final email = controlEmail.text.trim();
    final password = controlPassword.text.trim();


    final user = ParseUser.createUser(username, password, email)..set('Name',username);
    var response = await user.signUp();

    if (response.success) {
      createProfile(user);
      showSuccess();

    } else {
      showError(response.error.message);
    }
  }

  navigateToLogInPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Log_in_screen()),
    );
  }

}

