import 'package:firebase_database/firebase_database.dart';


class EventSpot {

  //Variable questions
  String key;
  String uid;
  String titre;
  String description;
  String adresse;
  String ville;
  String lat;
  String long;
  String geoPoint;
  String dateDebut;
  String dateFin;

  //Constructeur
  EventSpot({this.adresse, this.lat, this.long, this.dateFin,this.dateDebut, this.ville, this.description, this.titre, this.uid});

  EventSpot.fromSnapshot(DataSnapshot snapshot)
  {


    this.dateDebut = snapshot.value["Date début"];
    this.uid = snapshot.value["uid"];
    this.lat = snapshot.value["lat"];
    this.long = snapshot.value["lon"];
    this.dateFin = snapshot.value["Date de fin"];
    this.ville = snapshot.value["Ville"];
    this.description = snapshot.value["Description"];
    this.titre = snapshot.value["Titre"];
    this.adresse = snapshot.value["Adresse"];









  }



}