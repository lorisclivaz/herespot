import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:herespot/Models/events.dart';
import 'package:herespot/Models/user.dart';



class Database{

  //Variables de la classe database
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
  Future<String> createEvent(String titre, String description, String adresse, String ville, String debut,
      String fin, String lat, String long, String region, String uid) async {

    var event = <String, dynamic>{
      'Titre':titre,
      'Description':description,
      'Adresse':adresse,
      'Date de fin' : fin,
      'Date debut': debut,
      'Région': region,
      'Ville': ville,
      'lat': lat,
      'lon': long,
      'uid': uid
    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Properties").push();


    reference.set(event);
  }


  //Méthode permettant de récupérer l'item sur la map
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

  //Méthode permettant de créer un évènement
  Future<String> createUserInfo(String uid, String email) async {
    var user = <String, dynamic>{
      'Uid':uid,
      'Email':email,
    };
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Users").push();
    reference.set(user);
  }

  Future<String> getUserInfo(String uid, String email) async
  {
    final fb = FirebaseDatabase.instance.reference()
        .child('Users')
        .orderByKey();

    fb.once().then((DataSnapshot snap) {
      var data = snap.value;

      data.forEach((key, value) {
        User user = new User(
           uid: value['Uid'],
          email: value['Email'],
        );
        if(user.email == email)
        {
          return "Yes";
        }else{
          return null;
        }
      });

    });



  }

}