import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tracking/Infrastructure/Firebase/Auth/FireAuth.dart';

import 'Components/rounded_button.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext scaffoldContext;
  bool showSpinner = false;
  String email;
  String password;
  String code;
  FireAuth auth = FireAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value.trim();
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Introduce tu email'),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value.trim();
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Introduce tu contraseña'),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            code = value.trim();
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Código de acceso'),
                        ),
                        RoundedButton(
                          title: 'Entrar',
                          colour: Colors.deepPurpleAccent,
                          onPressed: () async {
                            this.login();
                          },
                        ),
                      ],
                    ))));
      }),
    );
  }

  void login() async {
    setState(() {
      showSpinner = true;
    });
    try {
      UserCredential userCredential =
          await this.auth.login(email, password, code);
      print(userCredential);
    } catch (e) {
      this.showSnackBar(e.message);
    }
    setState(() {
      showSpinner = false;
    });
  }

  void showSnackBar(String message) {
    final snackBar =
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent);
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }
}
