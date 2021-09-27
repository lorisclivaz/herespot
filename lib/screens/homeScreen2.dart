import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:herespot/Models/events.dart';
import 'package:herespot/screens/settings.dart';
import 'package:herespot/services/userInfo/UserInfo.dart';
import 'package:latlong/latlong.dart';
import 'package:herespot/Models/popup.dart';
import 'package:herespot/screens/listEvents.dart';
import 'package:herespot/screens/addEvents.dart';
import 'package:geolocator/geolocator.dart';




class HomeScreen2 extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marker Popup Demo',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MapPageScaffold(PopupSnap.markerTop),
    );
  }
}

class MapPageScaffold extends StatelessWidget {
  final PopupSnap popupSnap;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String email;

  MapPageScaffold(this.popupSnap);




  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;

    email =  user.email;
    print("User email "+ email);


    return Scaffold(
      appBar:  AppBar(

        backgroundColor: Colors.black38,
        title: Text('HereSpot'),
        centerTitle: true,
        elevation: 0.0,
        // actions


      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              // 현재 계정
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
                backgroundColor: Colors.white,
              ),
              // 다른 계정
              accountName: Text(email.toString()),

              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.grey[800],),
              title: Text('Liste évènements'),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ListEvents(),
                    ));
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey[800],),
              title: Text('Réglages'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Settings(),
                )
                );
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.question_answer, color: Colors.grey[800],),
              title: Text('Ajouter un évènement'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => addEvents(),)
                );
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
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
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight),
        child: FloatingActionButton.extended(
          label: Text(_isFirstSnap ? 'Charger les events' : 'Charger les events'),
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

  final fb = FirebaseDatabase.instance.reference().child('Properties').orderByKey();
  List<EventSpot> list = List();

  int compteur = 0;

  Position _currentPosition;
  String _currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;





  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    //Récupération des events
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key,value) {
        EventSpot event = new EventSpot(adresse: value['Adresse'],lat: value['lat'], long: value['lon'],dateFin: value['Date de fin'], ville: value['Ville'],tarif: value['Tarif'], description: value['Description'], titre: value['Titre']);

        LatLng cord = new LatLng(double.parse(value['lat'].toString()), double.parse(value['lon'].toString()));




            _points.add(cord);
            compteur ++;
            list.add(event);
            print(list.length);



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

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {


    return FlutterMap(
      options: MapOptions(
        zoom: 11.0,
        center: new LatLng(46.171614, 7.422938),
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