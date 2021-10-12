import 'dart:math';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herespot/database/database.dart';
import 'package:herespot/screens/homeScreen.dart';


class addEventsOnLongTap extends StatefulWidget {

  //Variables de la classe addeventsonlongtap
  double lat;
  double long;


  //Constructeur
  addEventsOnLongTap({this.lat, this.long});


  @override
  _addEventsOnLongTapState createState() => _addEventsOnLongTapState();
}

class _addEventsOnLongTapState extends State<addEventsOnLongTap> {

  //Variable d'édition de la classe addEventsState
  TextEditingController _titre = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _adresse = TextEditingController();
  TextEditingController _ville = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _latitude = TextEditingController();
  TextEditingController _longitude = TextEditingController();
  TextEditingController dateDebut = TextEditingController();
  TextEditingController dateFin = TextEditingController();
  int randomNumber;
  Database db = new Database();

  //Méthode permettant de récupérer l'adresse selon les points d'intérêt
  getUserLocation() async{
    List<Placemark> placemarks = await placemarkFromCoordinates(widget.lat, widget.long);
    Placemark place = placemarks[0];

    _adresse.text = place.street;
    _ville.text = place.locality;
    _region.text = place.country;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print('Ajout d''évènement 2 dispose !!!');
  }

  //Widget permettant d'ajouter un évènement sur la page homeScreen
  @override
  Widget build(BuildContext context) {

    var rng = new Random();
    int max = 100000000;
    int min = 81000000;
    randomNumber = min + rng.nextInt(max - min);


    getUserLocation();

    //Mise en forme de la page
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Ajouter un évènement'),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: (){
                Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => HomeScreen()));

              }
          ),
          // actions
        ),
        body: Stack(
            children:[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
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
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                          controller: _titre,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 25.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7)
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              labelText: "Ajouter un titre",
                              labelStyle: TextStyle(
                                  color: Colors.white24
                              ),
                              filled: true,
                              fillColor: Colors.black38,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              )),

                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20)
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 7,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                          controller: _description,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 25.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7)
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              labelText: "Ajouter une description",
                              labelStyle: TextStyle(
                                  color: Colors.white24
                              ),
                              filled: true,
                              fillColor: Colors.black38,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              )),

                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                          controller: _adresse,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 25.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7)
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              labelText: "Ajouter une adresse",
                              labelStyle: TextStyle(
                                  color: Colors.white24
                              ),
                              filled: true,
                              fillColor: Colors.black38,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              )),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20)
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                          controller: _ville,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 25.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7)
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              labelText: "Ajouter une ville",
                              labelStyle: TextStyle(
                                  color: Colors.white24
                              ),
                              filled: true,
                              fillColor: Colors.black38,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              )),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15)
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                          controller: _region,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 25.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7)
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              labelText: "Ajouter une region",
                              labelStyle: TextStyle(
                                  color: Colors.white24
                              ),
                              filled: true,
                              fillColor: Colors.black38,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              )),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
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
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                          controller: dateDebut,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 25.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7)
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              labelText: 'Date de début',
                              labelStyle: TextStyle(
                                  color: Colors.white24
                              ),
                              filled: true,
                              fillColor: Colors.black38,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              )),

                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
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
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                          ),
                          controller: dateFin,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 25.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25.7)
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              labelText: 'Date de fin',
                              labelStyle: TextStyle(
                                  color: Colors.white24
                              ),
                              filled: true,
                              fillColor: Colors.black38,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              )),

                        ),
                      ),

                      SizedBox(height : 10.0),
                      MaterialButton(
                        onPressed: () async {

                          _latitude.text = widget.lat.toString();
                          _longitude.text = widget.long.toString();


                          db.createEvent(_titre.text, _description.text, _adresse.text, _ville.text
                              , dateDebut.text, dateFin.text, _latitude.text, _longitude.text
                              , _region.text, randomNumber.toString());



                          Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => HomeScreen()), ).then((value) => setState(() {}));



                        },
                        height: 80,
                        minWidth: 300,
                        color: Colors.black,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Ajouter',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height : 10.0),

                    ],
                  ),
                ),
              ),
            ]
        )
    );
  }
}
