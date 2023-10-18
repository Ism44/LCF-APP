import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class GetStation extends StatelessWidget {
  final String documentid;
  GetStation({required this.documentid});

  @override
  Widget build(BuildContext context) {
  CollectionReference station = FirebaseFirestore.instance.collection('station');
  return FutureBuilder<DocumentSnapshot>(
    future: station.doc(documentid).get(),
    builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data= 
        snapshot.data!.data() as Map<String, dynamic>;
        return Text(' ${data['name']}');
      }
      return Text('loading...');
    });
  }
}