import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import 'get_station.dart';

class StationDetail extends StatefulWidget {
  String documentid;
  StationDetail({super.key, required this.documentid});

  @override
  State<StationDetail> createState() => _StationDetailState();
}

class _StationDetailState extends State<StationDetail> {
  int _quantity = 0;
  int _price = 0;
  int _total = 0;
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('station')
        .doc(widget.documentid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference station =
        FirebaseFirestore.instance.collection('station');
    return FutureBuilder<DocumentSnapshot>(
        future: station.doc(widget.documentid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return SafeArea(
                child: Scaffold(
              backgroundColor: Colors.grey.shade50,
              body: Center(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(20),
                        child: Container(
                            color: Colors.white,
                            width: double.maxFinite,
                            padding: EdgeInsets.only(top: 5, bottom: 10),
                            child: Center(
                                child: Text(
                              'Station Details',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ))),
                      ),
                      expandedHeight: 300,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Image.network(
                        '${data['image']}',
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      )),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Expanded(
                                    child: Text(
                                  '${data['name']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    width: 150,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(5, 5, 5, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                          Icons.location_on_outlined),
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      onPressed: () {
                                        launch('${data['location']}');
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 70,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(155, 54, 47, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${data['price']} EGP',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ]),
                              ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Note that you pay ${data['price']} EGP for each working day (12 hours) reserved",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Hot places to visit",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              child:
                                  Image(image: NetworkImage('${data['ad']} ')),
                              style: ElevatedButton.styleFrom(
                                // ignore: deprecated_member_use
                                primary: Colors.transparent,
                                // ignore: deprecated_member_use
                                onSurface: Colors.transparent,
                                shadowColor: Colors.transparent,
                                minimumSize: const Size.fromHeight(80),

                                // Background color
                              ),
                              onPressed: () {
                                launch('${data['adsite']}');
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 170,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(999)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => setState(() {
                                if (_quantity > 0) {
                                  _quantity = _quantity - 12;
                                }
                              }),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.grey.shade900,
                                child: Icon(Icons.remove),
                              ),
                            ),
                            Text(
                              '$_quantity hrs',
                              style: TextStyle(fontSize: 20),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _quantity = _quantity + 12;
                              }),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.grey.shade900,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_quantity > 0) {
                            _price = _quantity ~/ 12;
                            int _perhour = int.parse('${data['price']}');
                            int _total = _price * _perhour;
                            var now = new DateTime.now();
                            var formatter =
                                new DateFormat('yyyy-MM-dd kk:mm:ss');
                            String formattedDate = formatter.format(now);
                            Duration reservetime = Duration(hours: _quantity);
                            DateTime reserveEnd = now.add(reservetime);
                            print(formattedDate);
                            print(reserveEnd);

                            print(_total);
                            FirebaseFirestore.instance
                                .collection('reservation')
                                .add({
                                  "name": '${data['name']}',
                                  "reservedBy": user.email!,
                                  "image": '${data['image']}',
                                  "location": '${data['location']}',
                                  "TotalPrice": _total,
                                  "ExpieryDate": reserveEnd,
                                })
                                .then(
                                    (value) => print("Data added successfully"))
                                .catchError((error) =>
                                    print("Failed to add data: $error"));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('A total of ' +
                                    _total.toString() +
                                    'EGP has been subjected from your Credit Card')));

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LockerView()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "You didn't specify the duration of your reservation")));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 11, 160, 18)),
                          fixedSize: MaterialStateProperty.all(
                            const Size(double.infinity, 70),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Reserve',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          } else
            return Scaffold(
                body: Center(
              child: Text('loagding...'),
            ));
        });
  }
}
