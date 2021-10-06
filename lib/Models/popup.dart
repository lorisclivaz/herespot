import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:herespot/Models/events.dart';
import 'package:herespot/screens/DetailEvent.dart';

class Popup extends StatefulWidget {

  //Variable de la classe popup
  final Marker marker;
  final List<EventSpot> event;

  //Constructeur de la classe popup
  Popup(this.marker, this.event, {Key key}) : super(key: key);

  //On va créer l'état de la page
  @override
  _PopupState createState() => _PopupState(this.marker, this.event);
}

class _PopupState extends State<Popup> {

  //Variable de la classe popupstate
  int _currentIcon = 0;
  final Marker _marker;
  final List<EventSpot> _event;
  static String region =" ";
  static String titre = " ";
  static String ville = " ";
  static String dateDebut = " ";
  static String dateFin = ' ';
  static String uid = '';
  static String description = '';
  static String adresse = ' ';

  //Les variables de liste
  List<EventSpot> detailEvents = [];
  final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];

  //Constructeur
  _PopupState(this._marker, this._event);

  //Widget permettant d'afficher la popup
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: InkWell(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40, right: 10),
                child: Icon(_icons[_currentIcon]),
              ),
              _cardDescription(context),
            ],
          ),
          onTap: () => setState((){
            _currentIcon = (_currentIcon + 1) % _icons.length;
          }),
        ),
      ),
    );
  }

  //Widget correspondant à la mise en forme de la description de la popup
  Widget _cardDescription(BuildContext context)
  {

    _event.forEach((element) {

      double lat = double.parse(element.lat);
      double long = double.parse(element.long);

      if(lat == _marker.point.latitude && long == _marker.point.longitude)
        {
          EventSpot eventDetail = new EventSpot(titre: element.titre, description: element.description,adresse: element.adresse, ville: element.ville, dateFin: element.dateFin, long: element.long
          , lat: element.lat);

          //detailEvents.add(eventDetail);
          ville = element.ville;
          titre = element.titre;
          dateDebut = element.dateDebut;
          uid = element.uid;
          description = element.description;
          adresse = element.adresse;
          dateFin = element.dateFin;
          region = element.region;

          print(ville+"  " + titre+"  " + dateDebut+"  " + uid +" "+ region);



        }

    });

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        constraints: BoxConstraints(minWidth: 200, maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${titre}',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0


              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text('Date de début : ${dateDebut}',
            style: const TextStyle(fontSize: 15.0, color: Colors.white),),
            SizedBox(height: 10.0,),
            Text('Ville : ${ville}',
            style: const TextStyle(fontSize: 15.0, color: Colors.white),),
            SizedBox(height: 20.0,),
            MaterialButton(
              onPressed: ()  {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailEvent(uid, description, adresse, dateDebut, dateFin, titre, region,ville),
                    ));

              },
              height: 40,
              color: Colors.black,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Detail évènement',
                style: TextStyle(
                  fontSize: 15,
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

