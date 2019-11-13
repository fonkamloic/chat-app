import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/reusableButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password, email;
  dynamic user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kmyInputDecoration(
                    text: "Enter your email", colour: Colors.lightBlueAccent),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kmyInputDecoration(
                    text: "Enter your password",
                    colour: Colors.lightBlueAccent),
              ),
              SizedBox(
                height: 24.0,
              ),
              ReusableButton(
                text: "Log In",
                color: Colors.lightBlueAccent,
                onPress: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
