import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';


class SendEmail extends StatefulWidget {

  @override
  _SendEmailState createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'LorisClivaz',
          textColor: Colors.white,
          backgroundColor: Colors.red,
          email: 'lorisclivaz@hotmail.com',
          // textFont: 'Sail',
        ),
        backgroundColor: Colors.black,
        body: ContactUs(
            cardColor: Colors.white,
            textColor: Colors.teal.shade900,
            email: 'lorisclivaz@hotmail.com',
            companyName: 'Loris Clivaz',
            companyColor: Colors.white,
            dividerThickness: 2,
            githubUserName: 'lorisclivaz',
            linkedinURL:
            'https://www.linkedin.com/in/lorisclivaz/',
            tagLine: 'Flutter Developer',
            taglineColor: Colors.teal.shade100,
            twitterHandle: 'Loris Clivaz',
            instagram: 'loris_clivaz',
           ),
      ),
    );
  }
}
