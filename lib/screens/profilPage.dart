import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herespot/Models/infoCard.dart';
import 'package:herespot/screens/updateProfile.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  String email;
  String uid;


  @override
  Widget build(BuildContext context) {

    email = auth.currentUser.email.trim();
    uid = auth.currentUser.uid.trim();

    return Scaffold(
      appBar:  AppBar(

        backgroundColor: Colors.black,
        title: Text('Mon profile'),
        centerTitle: true,
        elevation: 0.0,
        // actions


      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            SizedBox(
              height: 100,

            ),
            Text(
              'Votre prénom',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),

            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),

            SizedBox(height: 30,),

            InfoCard(
              text: 'Lorisclivaz@hotmail.com',
              icon: Icons.email,

            ),
            SizedBox(height: 30,),

            MaterialButton(
              onPressed: () async{

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UpdateProfile(email: email),
                )
                );



              },
              height: 60,
              color: Colors.black12,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)                      ),
              child: Text(
                'Modifier mon profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
