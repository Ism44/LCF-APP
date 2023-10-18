import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lcf/main.dart';
import 'package:lcf/reusable_widgets/reusable_widget.dart';

import '../utilis/color_utilis.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _confirmpasswordTextController =
      TextEditingController();
  Future addUserDetails(String username, String email) async {
    await FirebaseFirestore.instance
        .collection('user')
        .add({'username': username, 'email': email});
  }

  bool passwordConfirmed() {
    if (_passwordTextController.text == _confirmpasswordTextController.text) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "The passwords you entered doesn't match, Please check again")));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("ad352a"),
          hexStringToColor("362AAD"),
          hexStringToColor("222224"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Username", Icons.person_outline,
                      false, _userNameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Your Email", Icons.person_outline,
                      false, _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Confirm Password", Icons.lock_outline,
                      true, _confirmpasswordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, bool, false, () async {
                    if (passwordConfirmed()) {
                     
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                             addUserDetails(
                        _userNameTextController.text,
                        _emailTextController.text,
                      );
                        print("New Account Created");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAppExt()));
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${error.toString()}')));
                        print("Error ${error.toString()}");
                      });
                      
                    }
                    else{   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "The passwords you entered doesn't match, Please check again")));}
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
