import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:herespot/Models/events.dart';



class Database{

  //Variables
  final getEvent = FirebaseDatabase.instance.reference().child("Properties");
  List<EventSpot> listEvents = List();


  //Méthode permettant de créer l'utilisateur dans la base de données
  Future<String> createUser(String nom, String prenom, String region, String email, String uid) async {

    var user = <String, dynamic>{
      'Nom':nom,
      'Prenom' : prenom,
      'Email': email,
      'Uid': uid

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("users").push();


    reference.set(user);
  }


  //Méthode permettant de créer un évènement
  Future<String> createEvent(String nom, String prenom, String region, String email, String uid) async {

    var user = <String, dynamic>{
      'Nom':nom,
      'Prenom' : prenom,
      'Email': email,
      'Uid': uid

    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("users").push();


    reference.set(user);
  }



  static Future<List> getItems( ) async {
    Completer<List> completer = new Completer<List>();

    FirebaseDatabase.instance
        .reference()
        .child("Properties")
        .once()
        .then( (DataSnapshot snapshot) {
      //print(snapshot.value);
      List map = snapshot.value;
      completer.complete(map);
    } );

    return completer.future;
  }

}