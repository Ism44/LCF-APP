import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lcf/station_details.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

import 'get_station.dart';
import 'utilis/color_utilis.dart';
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name ="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                   hexStringToColor("4285F4"),
                  hexStringToColor("DB4437"),
                  hexStringToColor("F4B400"),
                  hexStringToColor("0F9D58"),
                ]),
          ),
        ),
        title:Card(child: TextField(decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),hintText: 'Search...'),
         onChanged: (val){
          setState(() {
             name = val;
          });
         }, ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('station').snapshots(),
          builder: (context, snapshots) {
               List<String> docIDs = [];
  Future getDocId() async {
     FirebaseFirestore.instance
        .collection('station')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
             
            }));
  }
            return(snapshots.connectionState == ConnectionState.waiting)?Center(child: CircularProgressIndicator(),):
            ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index){
                var data = snapshots.data!.docs[index].data() as Map<String, dynamic>;
                if(name.isEmpty){
                    FutureBuilder(
                          future: getDocId(),
                          initialData: docIDs,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                     StationDetail(documentid: docIDs[index],)));
                                     return Container();
                          },
                        );
                  return  Padding( 
                        padding: const EdgeInsets.all(8.0),
                        child:
                   ListTile(
                        tileColor: Color.fromARGB(255, 0, 0, 0),
                    title: Text(data['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color:Color.fromARGB(255, 255, 255, 255),
                      fontSize:16,
                      fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(data['price']+'EGP per 12 hours',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color:Color.fromARGB(255, 6, 158, 6),
                      fontSize:16,
                      fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(backgroundImage:
                      NetworkImage(data['image']) ),
                       onTap: (){ 
                      Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                     StationDetail(documentid: docIDs[index],)));
                      },
                  ));
                }
                if(data['name'].toString().toLowerCase().startsWith(name.toLowerCase())){
                    FutureBuilder(
                          future: getDocId(),
                          initialData: docIDs,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                     StationDetail(documentid: docIDs[index],)));
                                     return Container();
                          },
                        );
                   return  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 
                   ListTile(

                   tileColor: Color.fromARGB(255, 0, 0, 0),
                    title: Text(data['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color:Color.fromARGB(255, 255, 255, 255),
                      fontSize:16,
                      fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(data['price'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color:Color.fromARGB(255, 255, 255, 255),
                      fontSize:16,
                      fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(backgroundImage:
                      NetworkImage(data['image']) ),
                         onTap: (){ Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                     StationDetail(documentid: docIDs[index],)));},
                  ));

                }
                return Container();
              });
          } ,
        ),
      );
  }
}