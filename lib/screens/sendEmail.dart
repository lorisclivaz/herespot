import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';


class SendEmail extends StatefulWidget {

  @override
  _SendEmailState createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print('SendEmail page dispose');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.black,
          title: Text('HereSpot'),
          centerTitle: true,
          elevation: 0.0,
          // actions
          leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ),
        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'LorisClivaz',
          textColor: Colors.white,
          backgroundColor: Colors.red,
          email: 'lorisclivaz@hotmail.com',
          // textFont: 'Sail',
        ),
        backgroundColor: Colors.white10,
        body: Column(
          children: [
            SizedBox(height: 50,),
            ContactUs(
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
          ],
        )
      ),
    );
  }
}
