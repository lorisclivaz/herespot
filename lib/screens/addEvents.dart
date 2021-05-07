import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class addEvents extends StatefulWidget {
  @override
  _addEventsState createState() => _addEventsState();
}

class _addEventsState extends State<addEvents> {

  TextEditingController _titre = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _adresse = TextEditingController();
  TextEditingController _ville = TextEditingController();
  TextEditingController _categorie = TextEditingController();
  TextEditingController _capacite = TextEditingController();
  TextEditingController _tarifs = TextEditingController();

  TextEditingController dateDebut = TextEditingController();
  TextEditingController dateFin = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text('Add Events'),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
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
                    shape: BoxShape.circle,
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
                  controller: _categorie,
                  decoration: InputDecoration(
                      labelText: "Catégorie",
                      border: OutlineInputBorder()),

                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: _capacite,
                  decoration: InputDecoration(
                      labelText: "Capacité",
                      border: OutlineInputBorder()),

                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: _tarifs,
                  decoration: InputDecoration(
                      labelText: "Tarif",
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
                onPressed: () {
                  Navigator.pop(context);

                  print(_titre.text);
                  print(_description.text);
                  print(_adresse.text);
                  print(_ville.text);
                  print(_categorie.text);
                  print(_capacite.text);
                  print(_tarifs.text);
                  print(dateDebut.text);
                  print(dateFin.text);

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
