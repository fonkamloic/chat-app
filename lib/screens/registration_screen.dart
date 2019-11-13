import 'package:flash_chat/components/reusableButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String password, email;
  dynamic newUser;
  bool showSpiner = false;
  void registerUser() async {
    try {} catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    registerUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpiner,
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
                    text: "Enter your email", colour: Colors.blueAccent),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kmyInputDecoration(
                    text: "Enter your password", colour: Colors.blueAccent),
              ),
              SizedBox(
                height: 24.0,
              ),
              ReusableButton(
                text: "Register",
                color: Colors.blueAccent,
                onPress: () async {
                  setState(() {
                    showSpiner = true;
                  });
                  try {
                    newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    print(newUser);
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpiner = false;
                  });
                  if (newUser != null) {
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
