import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herespot/database/database.dart';
import 'package:herespot/screens/homeScreen.dart';
import 'package:herespot/screens/homeScreen2.dart';


class addEvents extends StatefulWidget {
  @override
  _addEventsState createState() => _addEventsState();
}

class _addEventsState extends State<addEvents> {

  TextEditingController _titre = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _adresse = TextEditingController();
  TextEditingController _ville = TextEditingController();
  TextEditingController _infopratique = TextEditingController();
  TextEditingController _lien = TextEditingController();
  TextEditingController _tarifs = TextEditingController();
  TextEditingController _place = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _latitude = TextEditingController();
  TextEditingController _longitude = TextEditingController();



  TextEditingController dateDebut = TextEditingController();
  TextEditingController dateFin = TextEditingController();

  int randomNumber;

  Database db = new Database();




  @override
  Widget build(BuildContext context) {


    var rng = new Random();
    int max = 100000000;
    int min = 81000000;
    randomNumber = min + rng.nextInt(max - min);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Ajouter un évènement'),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => HomeScreen()), ).then((value) => setState(() {}));

            }
        ),
        // actions
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height : 10.0),
              Container(
                alignment: Alignment.center,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/herespot.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height : 10.0),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: _titre,
                  decoration: InputDecoration(
                      labelText: "Titre",
                      border: OutlineInputBorder()),

                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: _description,
                  decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder()),

                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: _adresse,
                  decoration: InputDecoration(
                      labelText: "Adresse",
                      border: OutlineInputBorder()),

                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: _ville,
                  decoration: InputDecoration(
                      labelText: "Ville",
                      border: OutlineInputBorder()),

                ),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: _region,
                  decoration: InputDecoration(
                      labelText: "Région",
                      border: OutlineInputBorder()),

                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: dateDebut,
                  decoration: InputDecoration(
                    labelText: "Begin date event",
                  border: OutlineInputBorder()),
                  onTap: () async{
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = await showDatePicker(
                        context: context,
                        initialDate:DateTime.now(),
                        firstDate:DateTime(1900),
                        lastDate: DateTime(2100));

                    dateDebut.text = "${date.day}.${date.month}.${date.year}";

                    },
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: dateFin,
                  decoration: InputDecoration(
                    labelText: "End date event",
                    hintText: DateTime.now().toString(),
                    border: OutlineInputBorder()),
                  onTap: () async{
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = await showDatePicker(
                        context: context,
                        initialDate:DateTime.now(),
                        firstDate:DateTime(1900),
                        lastDate: DateTime(2100));

                    dateFin.text = "${date.day}.${date.month}.${date.year}";
                    },
                ),
              ),

              SizedBox(height : 10.0),
              MaterialButton(
                onPressed: () async {

                  List<Location> location = await locationFromAddress("${_adresse.text}, ${_ville.text}");

                  print('Longitude : '+location[0].longitude.toString());
                  print('Latitude : '+location[0].latitude.toString());

                  _latitude.text = location[0].latitude.toString();
                  _longitude.text = location[0].longitude.toString();


                  db.createEvent(_titre.text, _description.text, _adresse.text, _ville.text
                      , dateDebut.text, dateFin.text, _latitude.text, _longitude.text
                      , _region.text, randomNumber.toString());




                  Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => HomeScreen2()), ).then((value) => setState(() {}));





                },
                height: 60,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height : 10.0),

            ],
          ),
        ),
      )
    );
  }
}
