import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lcf/main.dart';
import 'package:lcf/screens/signup_screen.dart';
import 'package:lcf/utilis/color_utilis.dart';

import '../reusable_widgets/reusable_widget.dart';class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _passwordTextController = TextEditingController();
   final _emailTextController = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container
      (
              width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [
        hexStringToColor("ad352a"),
        hexStringToColor("362AAD"),
        hexStringToColor("222224"),
      ],
      begin: Alignment.topCenter, end: Alignment.bottomCenter)
      ),
      child: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).size.height* 0.2 , 20 , 0),
        child: Column(
          children: <Widget>[
            logoWidget("images/lcflogomini.png"),
            SizedBox(height: 30,),
            reusableTextField("Enter Email", Icons.person_outline, false, _emailTextController),
            SizedBox(height: 30,),
            reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),

       SizedBox(height: 20,),
          signInSignUpButton(context, bool, true, () async {
           await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text.trim(), password: _passwordTextController.text.trim()).then((value) {
Navigator.push(context, 
MaterialPageRoute(builder: (context)=>MyAppExt())
);
 }).onError((error, stackTrace){ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(content: Text('${error.toString()}'))
  
 );
 print("Error ${error.toString()}");});
          }),
          signUpOption()


],
        )
          
          
          
          ,)
          ),
      ),
    );
  }

Row signUpOption(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have an account?",style:  TextStyle(color: Colors.white70)),
      GestureDetector(
        onTap: (){Navigator.push(context,
        MaterialPageRoute(builder: (context)=> SignUpScreen()));
        },
        child: const Text(
          "  Sign Up",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

}