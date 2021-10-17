import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herespot/Models/events.dart';


class DetailEvent extends StatefulWidget {

  //Variable de la classe detailEvent
  final String uid;
  final String description;
  final String adresse;
  final String dateDebut;
  final String dateFin;
  final String titre;
  final String region;
  final String ville;

  //Constructeur de la classe detailEvent
  DetailEvent(this.uid, this.description, this.adresse, this.dateDebut, this.dateFin, this.titre, this.region, this.ville);

  //On va créer le state de la page
  @override
  _DetailEventState createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {

  //Variable de la classe detailEventstate
   EventSpot eventdetail;
   String description;
   String adresse;
   String dateDebut;
   String dateFin;
   String titre;
   String region;
   String ville;

   //Methode qui se lance au moment du loading de la page
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print('Détail d''évèenement dispose !!!');
  }

  //Widget de rendu du détail de l'évènement
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
                          Center(
                            child: Text(
                              ' Début : ${dateDebut}            fin : ${dateFin}',
                              style: TextStyle(color: Colors.black, fontSize: 19),
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 60.0,
                                width: 170,
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
                                width: 170.0,
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

                      heroTag: 'Tag1',
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
                      heroTag: 'Tag2',
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
            FloatingActionButton.extended(
              label: Text("Aller à l'évènement"),

              heroTag: 'Tag3',
              backgroundColor: Colors.black,
              onPressed: (){

                Fluttertoast.showToast(msg: "Vous êtes enregistrer pour cette évènement");

                Navigator.pop(context);
              },
            ),
            SizedBox(height: 50,),

            FloatingActionButton.extended(
              label: Text("Retour vers la page d'accueil"),

              heroTag: 'Tag4',
              backgroundColor: Colors.black,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],


        ),
      ),
    );

  }
}
