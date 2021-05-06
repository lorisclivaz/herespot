import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:herespot/Models/events.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:herespot/Models/popup.dart';
import 'package:intl/intl.dart';



class HomeScreen2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marker Popup Demo',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MapPageScaffold(PopupSnap.markerTop),
    );
  }
}

class MapPageScaffold extends StatelessWidget {
  final PopupSnap popupSnap;

  MapPageScaffold(this.popupSnap);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page '),
        actions: [


        ],
      ),
      body: MapPage(popupSnap),
      floatingActionButton: _buttonToSwitchSnap(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget _buttonToSwitchSnap(BuildContext context) {
    /// Note this plugin doesn't currently support changing the snap type
    /// dynamically. To demo different snap types this rebuilds the page with
    /// the new snap type. If you have a use case for dynamically changing the
    /// snap please create a GitHub Issue describing the use case.
    return Padding(
      padding: EdgeInsets.only(top: kToolbarHeight),
      child: FloatingActionButton.extended(
        label: Text(_isFirstSnap ? 'Load events' : 'Load events'),
        onPressed: () {
          final newSnap =
          _isFirstSnap ? PopupSnap.mapBottom : PopupSnap.markerTop;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => MapPageScaffold(newSnap),
            ),
          );
        },
        icon: Icon(
            _isFirstSnap ? Icons.vertical_align_bottom_rounded : Icons.vertical_align_bottom_rounded),
        backgroundColor: Colors.green,
      ),
    );
  }

  bool get _isFirstSnap => popupSnap == PopupSnap.markerTop;
}

class MapPage extends StatefulWidget {
  final PopupSnap popupSnap;

  MapPage(this.popupSnap, {Key key}) : super(key: key);


  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static final List<LatLng> _points = [



  ];

  static const _markerSize = 40.0;
  List<Marker> _markers;

  DateTime now = DateTime.now();
  int year;
  int month;
  int day;


  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  final fb = FirebaseDatabase.instance.reference().child('Properties');
  List<EventSpot> list = List();

  int compteur = 0;

  @override
  void initState() {
    super.initState();



    //Récupération des solutions
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((value) {
        EventSpot event = new EventSpot(adresse: value['Adresse'],lat: value['lat'], long: value['lon'],dateFin: value['Date de fin'], ville: value['Ville'],tarif: value['Tarif'], description: value['Description'], titre: value['Titre']);

        LatLng cord = new LatLng(double.parse(value['lat'].toString()), double.parse(value['lon'].toString()));

        String eventYear = event.dateFin.substring(6,10);
        String eventMonth = event.dateFin.substring(3,5);
        String eventDay = event.dateFin.substring(0,2);

        int eventYearConv = int.parse(eventYear);
        int eventMonthConv = int.parse(eventMonth);
        int eventDayConv = int.parse(eventDay);


        year = now.year;
        month = now.month;
        day = now.day;

        if(eventYearConv >= year && eventMonthConv >= month && eventDayConv >= day && compteur < 10)
          {

            _points.add(cord);
            compteur ++;
            list.add(event);
          }


      });
      if(mounted)
      {
        setState(() {

        });
      }
    });
    _markers = _points
        .map(
          (LatLng point) => Marker(
        point: point,
        width: _markerSize,
        height: _markerSize,
        builder: (_) => Icon(Icons.location_on, size: _markerSize),
        anchorPos: AnchorPos.align(AnchorAlign.top),

      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 11.0,
        center: new LatLng(46.201506, 6.148434),
        plugins: [PopupMarkerPlugin()],
        onTap: (_) => _popupLayerController
            .hidePopup(), // Hide popup when the map is tapped.
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        PopupMarkerLayerOptions(
          markers: _markers,
          popupSnap: widget.popupSnap,
          popupController: _popupLayerController,
          popupBuilder: (BuildContext _, Marker marker) =>
          Popup(marker, list)

        ),
      ],
    );
  }
}