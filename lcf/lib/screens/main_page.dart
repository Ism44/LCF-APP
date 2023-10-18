import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'package:lcf/main.dart';
class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        
        builder: ( context,  snapshot) {
      if ( snapshot.hasData){
        return MyApp();
      } else {
        return SignInScreen();
      }
        },
      ),
    );
  }
}