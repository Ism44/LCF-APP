import 'package:flutter/material.dart';
class lockerdetails extends StatelessWidget {
  const lockerdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.transparent,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500        ),
          title: Text('Locker Details'),
          leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){},)
      ),
      body: Center(
        child: Column(
          children: [
            Container
            (padding: EdgeInsets.symmetric(horizontal: 60),
              width: double.infinity,
            height: 400,
            decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Image.network('https://www.egypttoday.com/siteimages/Larg/63794.jpg'))
          ],
        ),
      ),
    );
  }
}