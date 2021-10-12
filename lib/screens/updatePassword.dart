import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herespot/Models/userSecurity.dart';

class UpdatePassword extends StatefulWidget {

  //Création du state de la page
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {

  //Variable de la classe UpdatePassword
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _emailController;


  //Méthode d'initialisation
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController = TextEditingController();


  }

  //Méthode de suppression
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print('UpdatePassword page dispose !!!');

    _emailController.dispose();

  }

  //Widget qui va build la page updatePassword
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(

        backgroundColor: Colors.black,
        title: Text('HereSpot'),
        centerTitle: true,
        elevation: 0.0,
        // actions


      ),
     body: SafeArea(
       child: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 10.0,),
               TextFormField(
                 controller: _emailController,
                 validator: (val) =>
                 val.isNotEmpty ? null : 'Entrer votre adresse e-mail',
                 decoration: InputDecoration(
                     hintText: 'Email',
                     prefixIcon: Icon(Icons.security),
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10)
                     )
                 ),
               ),
               SizedBox(height: 20.0,),
               MaterialButton(

                 onPressed: () async {

                   String email;
                   email = _emailController.text.trim();
                   auth.sendPasswordResetEmail(email: email);
                   Navigator.of(context).pop();

                 },
                 height: 60,
                 color: Colors.black,
                 textColor: Colors.white,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20),
                 ),
                 child: Center(
                   child: Text(
                     'Envoyer',
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
     ),
    );
  }



}
