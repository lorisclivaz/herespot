import 'package:firebase_database/firebase_database.dart';


class EventSpot {

  //Variable questions
  String key;
  String uid;
  String titre;
  String description;
  String adresse;
  String ville;
  String tarif;
  String lat;
  String long;
  String geoPoint;
  String dateDebut;
  String dateFin;
  String image;
  String place;
  String lien;

  //Constructeur
  EventSpot({this.place,this.adresse, this.lat, this.long, this.dateFin,this.dateDebut, this.ville, this.tarif, this.description, this.titre, this.image, this.uid, this.lien});

  EventSpot.fromSnapshot(DataSnapshot snapshot)
  {

    this.lien = snapshot.value["Lien"];
    this.place = snapshot.value["Place"];
    this.uid = snapshot.value["Date début"];
    this.uid = snapshot.value["uid"];
    this.lat = snapshot.value["lat"];
    this.long = snapshot.value["lon"];
    this.dateFin = snapshot.value["Date de fin"];
    this.dateFin = snapshot.value["Ville"];
    this.dateFin = snapshot.value["Tarif"];
    this.dateFin = snapshot.value["Description"];
    this.dateFin = snapshot.value["Titre"];
    this.dateFin = snapshot.value["Adresse"];
    this.image = snapshot.value["Image"];









  }



}