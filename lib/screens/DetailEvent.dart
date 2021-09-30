
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
  final String titre;
  final String region;
  final String ville;

  DetailEvent(this.uid, this.description, this.adresse, this.dateDebut, this.dateFin, this.titre, this.region, this.ville);

  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {

  EventSpot eventdetail;

   String description;
   String adresse;
   String dateDebut;
   String dateFin;
   String titre;
   String region;
   String ville;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

 description = widget.description;
 adresse = widget.adresse;
 dateDebut = widget.dateDebut;
 dateFin = widget.dateFin;
 titre = widget.titre;
 region = widget.region;
 ville = widget.ville;

 print(ville);

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.black,
        title: Text('Détail évènement'),
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
                          Center(
                            child: Text(
                              '${titre}',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(.8)),
                            ),
                          ),
                          SizedBox(height: 40.0,),
                          Text(
                            ' Début : ${dateDebut}            fin : ${dateFin}',
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          SizedBox(height: 15.0,),
                          SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 60.0,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black12,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 2),
                                        blurRadius: 20.0,
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    ' Région : ${region} ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                height: 60.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black12,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 2),
                                        blurRadius: 20.0,
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Ville : ${ville}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                  SizedBox(height: 20,),
                  Center(
                    child: FloatingActionButton.extended(
                      label: Text('Adresse et N° :'),

                      backgroundColor: Colors.black,
                    ),
                  ),

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
                  SizedBox(height: 20,),
                  Center(
                    child: FloatingActionButton.extended(
                      label: Text('Description de l''évènement :'),
                      backgroundColor: Colors.black,
                    ),
                  ),
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

            SizedBox(height: 50,),
          ],

        ),
      ),
    );

  }
}
