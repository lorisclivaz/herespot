import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:herespot/Models/events.dart';

class Popup extends StatefulWidget {
  final Marker marker;
  final List<EventSpot> event;

  Popup(this.marker, this.event, {Key key}) : super(key: key);

  @override
  _PopupState createState() => _PopupState(this.marker, this.event);
}

class _PopupState extends State<Popup> {

  final Marker _marker;
  final List<EventSpot> _event;
  static String result ="";

  List<EventSpot> detailEvents = [];

  final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];

  int _currentIcon = 0;

  _PopupState(this._marker, this._event);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }


  Widget _cardDescription(BuildContext context)
  {
    print(_event.length);

    _event.forEach((element) {

      double lat = double.parse(element.lat);
      double long = double.parse(element.long);

      if(lat == _marker.point.latitude && long == _marker.point.longitude)
        {
          print( 'Name : ${element.ville}  ${element.dateFin}   ');

          EventSpot eventDetail = new EventSpot(titre: element.titre, description: element.description, tarif: element.tarif, adresse: element.adresse, ville: element.ville, dateFin: element.dateFin, long: element.long
          , lat: element.lat);

          detailEvents.add(eventDetail);

          result = element.ville;

        }

    });

    print('List :  ${detailEvents.length}');
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('PopuMarker',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text('Position : ${_marker.point.latitude}, ${_marker.point.longitude}',
            style: const TextStyle(fontSize: 12.0),),
            Text('Marker size : ${result}, ${_marker.height}',
            style: const TextStyle(fontSize: 12.0),)
          ],
        ),
      ),
    );
  }


}

