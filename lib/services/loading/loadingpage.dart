import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herespot/screens/homeScreen.dart';


class LoadingPage extends StatefulWidget {

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  //Variable de la classe loading page
  //Geolocation
  Position currentPosition;
  bool loading = true ;


  //Méthode d'initialisation
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _determinePosition();

  }


  //Méthode dispose permettant de supprimer le state    quand on change de page
  @override
  void dispose() {
    super.dispose();
  }

  //Visuel de la page
  @override
  Widget build(BuildContext context) {

    return loading ? CircularProgressIndicator(
      backgroundColor: Colors.black12,
      color: Colors.white,
    )
    : MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white30,
          body: Container(
            color: Colors.white30,
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                Text(
                  "HereSpot",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.20),
                const SpinKitPulse(
                  color: Colors.white,
                  size: 150.0,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                Text("Copyright Loris Clivaz, Arnaud Antille\n   Version 1.0",
                    style: TextStyle(color: Colors.white70, fontSize: 20.0))
              ],
            ),
          ),
        ));
  }


  //Méthode permettant de déterminer la position de l'utilisateur
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
        Fluttertoast.showToast(msg: 'Nous avons mis une localisation par défaut');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Nous avons mis une localisation par défaut');

      UserLocationAuto.latitudeUser = 46.8182;
      UserLocationAuto.longitudeuser = 8.2275;

      loading = false;

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);

    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);


    try {

      setState(() {

        currentPosition = position;

        UserLocationAuto.latitudeUser = currentPosition.latitude;
        UserLocationAuto.longitudeuser = currentPosition.longitude;


        if(UserLocationAuto.latitudeUser != null && UserLocationAuto.latitudeUser != null)
          {

            loading = false;

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);

          }

      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Un problème est survenu lors de la géolocalisation, veuillez vérifier votre connexion internet !');
    }

  }

  //Class static pour récupérer les valeurs de localisation de l'utilisateur
  }

  class UserLocationAuto{

  static double latitudeUser;
  static double longitudeuser;


  }