import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herespot/Models/events.dart';
import 'package:herespot/database/database.dart';
import 'package:herespot/screens/addEvents.dart';
import 'package:herespot/screens/addEventsOnLongTap.dart';
import 'package:herespot/screens/sendEmail.dart';
import 'package:herespot/screens/settings.dart';
import 'package:herespot/services/authentication/auth_services.dart';
import 'package:latlong/latlong.dart';
import 'package:herespot/Models/popup.dart';
import 'package:herespot/screens/addEvents.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {

  //Widget qui va build la homePage
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


class MapPageScaffold extends StatefulWidget {

  //Variable de la classe mapPageScaffold
  final PopupSnap popupSnap;

  //Constructeur de la classe mapPageScaffold
  MapPageScaffold(this.popupSnap);

  //On va créer le state de la page
  @override
  _MapPageScaffoldState createState() => _MapPageScaffoldState();
}

class _MapPageScaffoldState extends State<MapPageScaffold> {

  //Variable de la classe mappageScaffoldState
  final FirebaseAuth auth = FirebaseAuth.instance;
  String email;
  String uid;
  String password;
  String isRegister;
  Database db = new Database();



  //Méthode d'initialisation
  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }

  //Méthode de suppression du cache
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //Widget qui va build la home page
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);

    email = auth.currentUser.email.trim();

    return Scaffold(
      appBar:  AppBar(

        backgroundColor: Colors.black,
        title: Text('HereSpot'),
        centerTitle: true,
        elevation: 0.0,
        // actions


      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black12,
            brightness: Brightness.light
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: UserAccountsDrawerHeader(
                // 현재 계정
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                  backgroundColor: Colors.white,
                ),
                // 다른 계정
                accountName: Text(email.toString()),

                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              margin: EdgeInsets.only(top: 20),
              child: Wrap(
                  spacing: 10, // to apply margin horizontally
                  runSpacing: 10, // to apply margin vertically
                  children: [
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.white,),
                      title: Text('Liste évènements',style: TextStyle(color: Colors.white),),
                      onTap: (){

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings, color: Colors.white,),
                      title: Text('Réglages', style: TextStyle(color: Colors.white),),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Settings(),
                        )
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.question_answer, color: Colors.white,),
                      title: Text('Ajouter un évènement', style: TextStyle(color: Colors.white),),
                      onTap: (){

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => addEvents(),)
                        );

                      },
                      trailing: Icon(Icons.add, color: Colors.white,),
                    ),
                    ListTile(
                      leading: Icon(Icons.description, color: Colors.white,),
                      title: Text('Mention juridique', style: TextStyle(color: Colors.white),),
                      onTap: (){


                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.account_box, color: Colors.white,),
                      title: Text('Nous contacter', style: TextStyle(color: Colors.white),),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SendEmail(),
                        )
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red,),
                      title: Text('Déconnexion', style: TextStyle(color: Colors.white),),
                      onTap: (){

                        loginProvider.logout();


                      },
                    ),
                  ]
              ),
            ),

          ],
        ),
      ),
      body: MapPage(widget.popupSnap),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: _buttonToSwitchSnap(context),
    );
  }

  //Widget qui va permettre de charger les évènement
  Widget _buttonToSwitchSnap(BuildContext context) {
    /// Note this plugin doesn't currently support changing the snap type
    /// dynamically. To demo different snap types this rebuilds the page with
    /// the new snap type. If you have a use case for dynamically changing the
    /// snap please create a GitHub Issue describing the use case.
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight),
        child: FloatingActionButton.extended(
          label: Text(_isFirstSnap ? 'Charger les évènements' : 'Charger les évènements'),
          onPressed: () {

            final newSnap =
            _isFirstSnap ? PopupSnap.markerTop : PopupSnap.markerTop;
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => MapPageScaffold(newSnap),
              ),
            );
          },
          icon: Icon(
              _isFirstSnap ? Icons.vertical_align_bottom_rounded : Icons.vertical_align_bottom_rounded),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }

  bool get _isFirstSnap => widget.popupSnap == PopupSnap.markerTop;
}

class MapPage extends StatefulWidget {

  //Variable de la classe map page
  final PopupSnap popupSnap;

  //Constructeur de la classe mapPage
  MapPage(this.popupSnap, {Key key}) : super(key: key);

  //On va créer le state de la page
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  //Variable de la classe MapPageState
  static final List<LatLng> _points = [];
  static const _markerSize = 40.0;
  List<Marker> _markers;
  DateTime now = DateTime.now();
  int year;
  int month;
  int day;
  final PopupController _popupLayerController = PopupController();
  final fb = FirebaseDatabase.instance.reference()
      .child('Properties')
      .orderByKey();
  List<EventSpot> list = List();
  int compteur = 0;

  //Geolocation
  Position currentPosition;

  double latTemp = 46.8182;
  double longTemp = 8.2275;




  Future<Position>_determinePosition() async
  {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      Fluttertoast.showToast(
          msg: 'merci de mettre votre localisation sur votre téléphone');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        Fluttertoast.showToast(msg: 'La localisation n''est pas autorisé');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'La permission est enlevé pour toujours');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);


    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentPosition = position;
        latTemp = currentPosition.latitude;
        longTemp = currentPosition.longitude;
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Un problème est survenu lors de la géolocalisation');
    }

    print("user Location : "+ currentPosition.longitude.toString()+"  "+ currentPosition.latitude.toString());
  }

  //Méthode de suppression
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    list.clear();
  }

  //Méthode d'initialisation
  @override
  void initState() {
    super.initState();

    _determinePosition();

    //Récupération des events
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key, value) {
        EventSpot event = new EventSpot(adresse: value['Adresse'],
            lat: value['lat'],
            long: value['lon'],
            dateFin: value['Date de fin'],
            dateDebut: value['Date debut'],
            ville: value['Ville'],
            description: value['Description'],
            titre: value['Titre'],
            uid: value['uid'],
            region: value['Région']);

        LatLng cord = new LatLng(double.parse(value['lat'].toString()),
            double.parse(value['lon'].toString()));


        _points.add(cord);
        compteur ++;
        list.add(event);
      });
      if (mounted) {
        setState(() {

        });
      }
    });

    _markers = _points
        .map(
          (LatLng point) =>
          Marker(
            point: point,
            width: _markerSize,
            height: _markerSize,
            builder: (_) => Icon(Icons.location_on, size: _markerSize),
            anchorPos: AnchorPos.align(AnchorAlign.top),

          ),
    )
        .toList();

  }




  //Widget permettant d'afficher la carte
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        onLongPress: (latlang) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => addEventsOnLongTap(lat: latlang.latitude, long: latlang.longitude),
            )

            );

            },
        zoom: 5.0,
        //Inérer la localisation du User
        center: new LatLng(latTemp, longTemp),
        plugins: [PopupMarkerPlugin()],
        onTap: (_) =>
            _popupLayerController
                .hidePopup(),
        // Hide popup when the map is tapped.
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

