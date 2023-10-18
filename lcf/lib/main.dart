// ignore: unused_import
// ignore_for_file: deprecated_member_use, duplicate_ignore, sort_child_properties_last

// ignore: unused_import
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:lcf/Search.dart';
import 'package:lcf/Station_details2.0.dart';
import 'package:lcf/firebase_options.dart';
import 'package:lcf/get_station.dart';
import 'package:lcf/reservation_details.dart';
import 'package:lcf/screens/OnBoardingScreen.dart';
import 'package:lcf/screens/chatbot.dart';
import 'package:lcf/screens/payment.dart';
import 'package:lcf/screens/signin_screen.dart';
import 'package:lcf/station_details.dart';
import 'package:lcf/utilis/color_utilis.dart';

import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

import 'get_station.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart';
// ignore: unused_import
import 'package:flutter/gestures.dart';
// ignore: unused_import
import 'get_reservation.dart';
import 'get_user.dart';
import 'next_page.dart';
import 'station_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // ignore: override_on_non_overriding_member

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: OnBoardingScreen());
  }
}

class MyAppExt extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyAppExt({super.key});

  @override
  State<MyAppExt> createState() => _MyAppExtState();
}

// ignore: unused_element
bool _isClicked = false;

class _MyAppExtState extends State<MyAppExt> {
  final user = FirebaseAuth.instance.currentUser!;
  String buttonName = 'Click';
  int currentIndex = 0;
  int _current = 0;
  final List<String> images = [
    'https://thinkmarketingmagazine.com/wp-content/uploads/2017/03/Think-Marketing-Majid-Al-Futtaim-Opens-the-doors-of-Mall-of-Egypt.png',
    'https://pbs.twimg.com/media/CONv0e8VAAQWzd6.jpg',
    'https://crystalfountains.com/wp-content/uploads/2021/06/Cairo-Festival-City-17.jpg'
  ];
  final List<String> places = [
    'Mall of Egypt',
    'Mall of Arabia',
    'Cairo Festival'
  ];
  List<Widget> generateImageTiles() {
    return images
        .map((element) => ClipRRect(
              child: Image.network(element, fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15.0),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Column(
          children: [
            Text(
              'Hello ' + user.email!,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              'need a locker?',
              style: TextStyle(fontSize: 10, color: Colors.black),
            )
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Search()));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: currentIndex == 0
          ? Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(0, 0, 0, 1),

                            Color.fromRGBO(0, 0, 0, 1)
                            //add more colors
                          ]),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.57), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: ElevatedButton(
                        child: Image(
                            image: NetworkImage(
                                'https://adigitalboom.com/wp-content/uploads/2022/04/vodafone-ad-2022-ramadan-digital-boom.jpg')),
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
                          launch(
                              "https://web.vodafone.com.eg/en/home?c_id=DACW0037&c_content=Website&c_medium=PPC&c_name=PureBrandEN&c_source=Search&c_term=PureBrandEN&c_type=Anonymous&c_phase=awareness&c_date=1218&gclid=CjwKCAjw6vyiBhB_EiwAQJRopqqtTzdX74XMBQe5iTQd-ToAvZWIWLM4r07ob57cUuxRz7mums9RWBoCI98QAvD_BwE");
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30, // <-- SEE HERE
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            hexStringToColor("c82e1a"),
                            hexStringToColor("c82e1a"),

                            //add more colors
                          ]),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.57), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: ElevatedButton(
                        child: Image.asset("images/learn-more-about-lcf.png"),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const NextPage()));
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    ColoredBox(
                      color: hexStringToColor("fafafa"),
                      child: Column(children: [
                        Text(
                          "Station Categories",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: const ShapeDecoration(
                                color: Color.fromARGB(255, 12, 13, 99),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.airplane_ticket),
                                iconSize: 40,
                                color: Color.fromARGB(255, 40, 106, 204),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const AirportC()));
                                },
                              ),
                            ),
                            Container(
                              decoration: const ShapeDecoration(
                                color: Color.fromARGB(255, 131, 29, 11),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                iconSize: 40,
                                icon: const Icon(
                                  Icons.local_mall,
                                ),
                                color: Color.fromARGB(255, 255, 255, 255),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const MallC()));
                                },
                              ),
                            ),
                            Container(
                              decoration: const ShapeDecoration(
                                color: Color.fromARGB(255, 44, 158, 22),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                iconSize: 40,
                                icon: const Icon(Icons.directions_bus),
                                color: Color.fromARGB(255, 255, 255, 253),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const BusStationC()));
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      color: hexStringToColor("fafafa"),
                      child: Column(children: [
                        Text(
                          "Hottest Stations",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Stack(
                          children: [
                            CarouselSlider(
                                items: generateImageTiles(),
                                options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, other) {
                                      setState(() {
                                        _current = index;
                                      });
                                    },
                                    autoPlay: true,
                                    aspectRatio: 18 / 8)),
                            AspectRatio(
                              aspectRatio: 18 / 8,
                              child: Center(
                                  child: Text(
                                places[_current],
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 15),
                              )),
                            )
                          ],
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            )
          : GestureDetector(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 134, 36, 11),
              ),
              child: Text(
                user.email!,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              title: const Text(
                'View your lockers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LockerView()));
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card, color: Colors.black),
              title: const Text(
                'Payment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MySample()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person_2, color: Colors.black),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ProfileConfirmation()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.black),
              title: const Text(
                'Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Help()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: const Text(
                'Log Out',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) => {
                      print("Signed Out"),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()))
                    });
              },
            ),
            Expanded(child: Image.asset('images/lcfwhite.png'))
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                  Color.fromARGB(255, 8, 47, 114),
                  Color.fromARGB(255, 30, 11, 66),
                  Color.fromRGBO(155, 54, 47, 1)
                ])),
          ),
          title: SingleChildScrollView(
            child: Column(
              children: const [
                Text(
                  'How does it work?',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          color: Color.fromARGB(255, 134, 4, 4),
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.all(10),
          child:
              SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Text(
                'Reserving a locker',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                          ),
                          SizedBox(
                width: 30,
                          ),
                          Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'As a customer reserve a locker by the use of our app they must have first signed up into our app, using the sign up form we collect the user id which is the E-mail and use it so the locker is reserved under that specific E-mail, We collect the number of hours given by the user and the payment before the reservation is finalized',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                          Text(
                'While having a locker reserved',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                          ),
                          Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "While the locker is reserved the user can access it's information as well as cancel their reservation if needed although it should be noted that while under a reservation a locker may be accessed by one of our admins for a random check up as said per our terms and services",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                          Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "What if I didn't collect my things before my reservation is due?",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                          Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Don't worry!, Since most of our lockers are found within public areas such as Malls and Airports, Your belongings will be transfered to Losts and founds by one of our admins as well as providing the losts and founds keepr with your 'Username' to ensure your belongings won't be accessed by any other party other than yourself.",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                        ]),
              ),
        ));
  }
}

class LockerView extends StatefulWidget {
  LockerView({super.key});

  @override
  State<LockerView> createState() => _LockerViewState();
}

class _LockerViewState extends State<LockerView> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('reservation');

  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('reservation')
        .where('reservedBy', isEqualTo: user.email!)
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MyAppExt()));
          },
        ),
        title: Text('Reserved Stations'),
        backgroundColor: hexStringToColor("c82e1a"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reservation')
            .where('reservedBy', isEqualTo: user.email!)
            .snapshots(),
        builder: (context, snapshots) {
          List<String> docIDs = [];
          Future getDocId() async {
            FirebaseFirestore.instance
                .collection('reservation')
                .where('reservedBy', isEqualTo: user.email!)
                .get()
                .then((snapshot) => snapshot.docs.forEach((document) {
                      print(document.reference);
                      docIDs.add(document.reference.id);
                    }));
          }

          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    final Timestamp timestamp =
                        data['ExpieryDate'] as Timestamp;
                    final DateTime dateTime = timestamp.toDate();
                    final dateString =
                        DateFormat('yyyy-MM-dd kk:mm:ss').format(dateTime);

                    FutureBuilder(
                      future: getDocId(),
                      initialData: docIDs,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => StationDetail(
                                  documentid: docIDs[index],
                                )));
                        return Container();
                      },
                    );

                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Reservation Ends" + dateString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 158, 15, 15),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(data['image'])),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ReservatoionDetails(
                                      documentid: docIDs[index],
                                    )));
                          },
                        ));
                  });
        },
      ),
    );
  }
}

class settings extends StatefulWidget {
  String documentid;
  settings({super.key, required this.documentid});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final user = FirebaseAuth.instance.currentUser!;

  bool isObscurePassword = true;
  @override
  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    })
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
      ),
    );
  }

  Widget build(BuildContext context) {
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

    CollectionReference station = FirebaseFirestore.instance.collection('user');
    return FutureBuilder<DocumentSnapshot>(
        future: station.doc(widget.documentid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                title: Column(
                  children: const [
                    Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: Container(
                padding: EdgeInsets.only(left: 15, top: 20, right: 15),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      buildTextField('Username', '${data['username']}', false),
                      buildTextField('Email', user.email!, false),
                      buildTextField('Password', '********', true),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyAppExt()));
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2,
                                  color: Colors.black),
                            ),
                            style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Save",
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else
            return Scaffold(
                body: Center(
              child: Text('loagding...'),
            ));
        });
  }
}

class ProfileConfirmation extends StatefulWidget {
  const ProfileConfirmation({super.key});

  @override
  State<ProfileConfirmation> createState() => _ProfileConfirmationState();
}

class _ProfileConfirmationState extends State<ProfileConfirmation> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: user.email!)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Column(
          children: const [
            Text(
              'Settings',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Color.fromARGB(255, 155, 60, 60),
                        title: Text(
                          "Note: changing your account information will be permanent and reservation made under your old E-mail will be dropped so only change when you don't have any ongoing reservations. Click here if you wish to continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => settings(
                                    documentid: docIDs[index],
                                  )));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Column(
          children: const [
            Text(
              'Visit us on our social media',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton.icon(
                icon:
                    const Icon(Icons.facebook), //icon data for elevated button
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: const Color.fromARGB(255, 51, 60, 184),

                  minimumSize: const Size.fromHeight(500),

                  // Background color
                ),
                onPressed: () {
                  launch('https://www.facebook.com/groups/527852429105719');
                },
                label: const Text('Contact us through our Facebook page')),
            ElevatedButton.icon(
                icon: const Icon(Icons.email), //icon data for elevated button
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: const Color.fromARGB(255, 156, 17, 17),

                  minimumSize: const Size.fromHeight(500),

                  // Background color
                ),
                onPressed: () {},
                label:
                    const Text('Contact us via E-mail at LCF.AAST@yahoo.com')),
            DecoratedBox(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 104, 9, 107),
                    Color.fromARGB(255, 129, 11, 11),
                    Color.fromRGBO(170, 156, 34, 1)
                    //add more colors
                  ]),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color:
                            Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]),
              child: ElevatedButton.icon(
                  icon: const Icon(
                      Icons.camera_alt), //icon data for elevated button
                  // ignore: duplicate_ignore, duplicate_ignore
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: Colors.transparent,
                    // ignore: deprecated_member_use
                    onSurface: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size.fromHeight(500),

                    // Background color
                  ),
                  onPressed: () {
                    launch('https://www.instagram.com/lcf.aast/');
                  },
                  label: const Text('Contact us via our instagram page')),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminC extends StatefulWidget {
  const AdminC({super.key});

  @override
  State<AdminC> createState() => _AdminCState();
}

class _AdminCState extends State<AdminC> {
//document IDS
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('station')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stations'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 155, 155, 155),
                          title: GetStation(documentid: docIDs[index]),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    StationDetail(
                                      documentid: docIDs[index],
                                    )));
                          },
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      )),
    );
  }
}

class AirportC extends StatefulWidget {
  const AirportC({super.key});

  @override
  State<AirportC> createState() => _AirportCState();
}

class _AirportCState extends State<AirportC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airport Station'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color.fromARGB(255, 16, 14, 143),
                  Color.fromARGB(255, 0, 0, 0)
                ]),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('station')
            .where('category', isEqualTo: 'Airport')
            .snapshots(),
        builder: (context, snapshots) {
          List<String> docIDs = [];
          Future getDocId() async {
            FirebaseFirestore.instance
                .collection('station')
                .where('category', isEqualTo: 'Airport')
                .get()
                .then((snapshot) => snapshot.docs.forEach((document) {
                      print(document.reference);
                      docIDs.add(document.reference.id);
                    }));
          }

          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    FutureBuilder(
                      future: getDocId(),
                      initialData: docIDs,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => StationDetail(
                                  documentid: docIDs[index],
                                )));
                        return Container();
                      },
                    );
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['price'] + 'EGP per 12 hours',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 6, 158, 6),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(data['image'])),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    StationDetail(
                                      documentid: docIDs[index],
                                    )));
                          },
                        ));
                  });
        },
      ),
    );
  }
}

class MallC extends StatefulWidget {
  const MallC({super.key});

  @override
  State<MallC> createState() => _MallCState();
}

class _MallCState extends State<MallC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mall Station'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color.fromARGB(255, 212, 25, 0),
                  Color.fromARGB(255, 0, 0, 0)
                ]),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('station')
            .where('category', isEqualTo: 'Mall')
            .snapshots(),
        builder: (context, snapshots) {
          List<String> docIDs = [];
          Future getDocId() async {
            FirebaseFirestore.instance
                .collection('station')
                .where('category', isEqualTo: 'Mall')
                .get()
                .then((snapshot) => snapshot.docs.forEach((document) {
                      print(document.reference);
                      docIDs.add(document.reference.id);
                    }));
          }

          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    FutureBuilder(
                      future: getDocId(),
                      initialData: docIDs,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => StationDetail(
                                  documentid: docIDs[index],
                                )));
                        return Container();
                      },
                    );
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['price'] + 'EGP per 12 hours',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 6, 158, 6),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(data['image'])),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    StationDetail(
                                      documentid: docIDs[index],
                                    )));
                          },
                        ));
                  });
        },
      ),
    );
  }
}

class BusStationC extends StatefulWidget {
  const BusStationC({super.key});

  @override
  State<BusStationC> createState() => _BusStationCState();
}

class _BusStationCState extends State<BusStationC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Station'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color.fromARGB(255, 0, 155, 0),
                  Color.fromARGB(255, 0, 0, 0)
                ]),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('station')
            .where('category', isEqualTo: 'Bus station')
            .snapshots(),
        builder: (context, snapshots) {
          List<String> docIDs = [];
          Future getDocId() async {
            FirebaseFirestore.instance
                .collection('station')
                .where('category', isEqualTo: 'Bus station')
                .get()
                .then((snapshot) => snapshot.docs.forEach((document) {
                      print(document.reference);
                      docIDs.add(document.reference.id);
                    }));
          }

          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    FutureBuilder(
                      future: getDocId(),
                      initialData: docIDs,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => StationDetail(
                                  documentid: docIDs[index],
                                )));
                        return Container();
                      },
                    );
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 0, 0, 0),
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['price'] + 'EGP per 12 hours',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 6, 158, 6),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(data['image'])),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    StationDetail(
                                      documentid: docIDs[index],
                                    )));
                          },
                        ));
                  });
        },
      ),
    );
  }
}
