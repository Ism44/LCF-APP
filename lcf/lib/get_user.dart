import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Getuser extends StatelessWidget {
  final String documentid;
  Getuser({required this.documentid});
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
  CollectionReference station = FirebaseFirestore.instance.collection('user');
  return FutureBuilder<DocumentSnapshot>(
    future: station.doc(documentid).get(),
    builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data= 
        snapshot.data!.data() as Map<String, dynamic>;
        return Text(' ${data['username']}');
      }
      return Text('loading...');
    });
  }
}