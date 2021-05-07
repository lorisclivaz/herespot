import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Database
{

  //Méthode permettant d'insérer une correction dans la base de données
  Future<String> insertCorrectionQuestion(String titre, int description, String adresse, String ville, String categorie, String capacite, String tarif, String datedebut, String dateFin) async{

    var response = <String, dynamic>{


    };

    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("CorrectionQuiz").push();


    reference.set(response);
  }






}