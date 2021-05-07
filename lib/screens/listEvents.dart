import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:herespot/Models/events.dart';

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




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Récupération des events
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((value) {
        EventSpot event = new EventSpot(adresse: value['Adresse'],lat: value['lat'], long: value['lon'],dateFin: value['Date de fin'], ville: value['Ville'],tarif: value['Tarif'], description: value['Description'], titre: value['Titre'],image: value['Image']);

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




  @override
  Widget build(BuildContext context) {

    List<EventSpot> events = List();

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
      body: Column(
        children: [
      Padding (
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        controller: _textController,
        onChanged: (text) {
          print('salut');
          text = "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}";
          setState(() {
            filteredList = list
                .where((element) => element.dateDebut.toLowerCase().contains(text))
                .toList();


          });
        },
      ),
    ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context), // Refer step 3
            child: Text(
              'Select date',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Colors.greenAccent,

          ),

          if (filteredList.length == 0)
            Expanded(
                child: Container(
                    child: Text("No Result Found")
                )
            )
          else
            Expanded(
                child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                          child: Text(filteredList[index].dateDebut)
                      );
                    }
                )
            )
        ]
      ));

  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),

    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        _textController.text = "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}";
      });
  }
}
