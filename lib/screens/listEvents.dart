import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:herespot/Models/events.dart';
import 'package:herespot/screens/DetailEvent.dart';

class ListEvents extends StatefulWidget {
  @override
  _ListEventsState createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {

  final fb = FirebaseDatabase.instance.reference().child('Properties');
  List<EventSpot> list = List();
  DateTime now = DateTime.now();
  int year;
  int month;
  int day;

  int compteur = 0;


  //DatePicker
  DateTime selectedDate = DateTime.now();
  List<EventSpot> filteredList = List();
  TextEditingController _textController = TextEditingController();

  List<EventSpot> newEventList = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Récupération des events
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((value) {
        EventSpot event = new EventSpot(lien:value['Lien'] ,uid:value['uid'] ,adresse: value['Adresse'],lat: value['lat'], long: value['lon'],dateFin: value['Date de fin'],dateDebut:value['Date début'] , ville: value['Ville'],tarif: value['Tarif'], description: value['Description'], titre: value['Titre'],image: value['Image']);

        String eventYear = event.dateFin.substring(6,10);
        String eventMonth = event.dateFin.substring(3,5);
        String eventDay = event.dateFin.substring(0,2);

        int eventYearConv = int.parse(eventYear);
        int eventMonthConv = int.parse(eventMonth);
        int eventDayConv = int.parse(eventDay);


        year = now.year;
        month = now.month;
        day = now.day;

        if(eventYearConv >= year && eventMonthConv >= month && eventDayConv >= day && compteur < 30 && event.titre != null && event.description != null && event.adresse != null && event.tarif != null)
        {
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




  }

  void _onItemChanged(String value) {
    setState(() {
      newEventList = list.where((val) {
        return val.ville.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {

    // print(list.length);
    //for(var i = 0; i< list.length; i++) {
    //print(list[i].titre);
    //}

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.black38,
        title: Text('List events'),
        leading:  IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        // actions

      ),


      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 80,

              child: Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Recherche Ville'
                  ),
                  onChanged:_onItemChanged ,
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemBuilder: (context, i)
                  {
                    return GestureDetector(
                      onTap: (){

                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailEvent(list[i].uid, list[i].description, list[i].adresse, list[i].dateDebut
                                  , list[i].dateFin, list[i].tarif, list[i].place, list[i].titre, list[i].lien),
                              ),);


                        print(list[i].uid);
                      },
                      child: Card(
                        elevation: 5.0,
                        margin:EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 5.0) ,
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Début : ${list[i].dateDebut}            Fin: ${list[i].dateFin}       Ville: ${list[i].ville}  ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "${list[i].adresse}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: newEventList.length,
                )
            )
          ],
        ),
      ),//Body
    );

  }


}
