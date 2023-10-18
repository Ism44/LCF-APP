import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'get_station.dart';

class ReservatoionDetails extends StatefulWidget {
  String documentid;
  ReservatoionDetails({super.key, required this.documentid});

  @override
  State<ReservatoionDetails> createState() => _ReservatoionDetailsState();
}

class _ReservatoionDetailsState extends State<ReservatoionDetails> {
  int _quantity = 0;
  int _price = 0;
  int _total = 0;
  late final _ratingController;
  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;
  @override
  void initState() {
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('reservation')
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
        FirebaseFirestore.instance.collection('reservation');
    return FutureBuilder<DocumentSnapshot>(
        future: station.doc(widget.documentid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final Timestamp timestamp = data['ExpieryDate'] as Timestamp;
            final DateTime dateTime = timestamp.toDate();
            final dateString =
                DateFormat('yyyy-MM-dd kk:mm:ss').format(dateTime);
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
                                        '${data['TotalPrice']} EGP',
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
                              "Note that your reservation will end at " +
                                  dateString,
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Make sure to rate your experience at \n " +
                                  '${data['name']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 200,
                              height: 40,
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  color: Color.fromARGB(255, 12, 37, 75)),
                              child: RatingBar.builder(
                                  itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: Color.fromARGB(255, 145, 17, 8),
                                    );
                                  case 1:
                                    return Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: Colors.red,
                                    );
                                  case 2:
                                    return Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    );
                                  case 3:
                                    return Icon(
                                      Icons.sentiment_satisfied,
                                      color: Colors.lightGreen,
                                    );
                                  case 4:
                                    return Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                  default:
                                    return Text("");
                                }
                              }, onRatingUpdate: (rating) {
                                print(rating);
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: 150,
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
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('reservation')
                              .doc(widget.documentid)
                              .delete();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => LockerView()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 146, 5, 5)),
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
                          'Cancel Reservation',
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
