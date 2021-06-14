
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:herespot/Models/events.dart';
import 'package:herespot/screens/webView.dart';


class DetailEvent extends StatefulWidget {
  final String uid;
  final String description;
  final String adresse;
  final String dateDebut;
  final String dateFin;
  final String tarif;
  final String place;
  final String titre;
  final String lien;

  DetailEvent(this.uid, this.description, this.adresse, this.dateDebut, this.dateFin, this.tarif, this.place, this.titre, this.lien);

  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {

  EventSpot eventdetail;

   String description;
   String adresse;
   String dateDebut;
   String dateFin;
   String tarif;
   String place;
   String titre;
   String lien;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

 description = widget.description;
 adresse = widget.adresse;
 dateDebut = widget.dateDebut;
 dateFin = widget.dateFin;
 tarif = widget.tarif;
 place = widget.place;
 titre = widget.titre;
 lien = widget.lien;


  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.black38,
        title: Text('Détail event'),
        leading:  IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        // actions

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(.3)),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${titre}',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(.8)),
                          ),
                          Text(
                            ' Début : ${dateDebut}            fin : ${dateFin}',
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(.3)),
            )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12, top: 24, bottom: 13),
                    child: Text(
                      '${adresse}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.8)),
                    ),
                  ),
                ],

              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(.3)),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12, top: 24, bottom: 13),
                    child: Text(
                      '${description}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.8)),
                    ),
                  ),
                ],

              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(.3)),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12, top: 24, bottom: 13),
                    child: Text(
                      '${tarif}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.8)),
                    ),
                  ),
                ],

              ),
            ),
            MaterialButton(
              onPressed: () async{

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        WebViewScreen(lien),
                  ),);
              },
              height: 60,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child:  Text(
                'Inscription',
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
