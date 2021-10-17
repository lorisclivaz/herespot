
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {

  final String email;

   UpdateProfile({this.email});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  TextEditingController _emailController;
  TextEditingController _nomController;
  TextEditingController _prenomController;
  
  //Image user
  File _pickedImage;
  




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(

        backgroundColor: Colors.black,
        title: Text('Modification du profile'),
        centerTitle: true,
        elevation: 0.0,
        leading:  IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: (){
          Navigator.pop(context);
        }
    ),
        // actions

      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:
            [
              Center(
                child: CircleAvatar(
                  radius: 150,
                  child: _pickedImage == null ? Text('Picture') : null,
                  backgroundImage: _pickedImage != null ? FileImage(_pickedImage) :
                      null
                ),
              ),
              RaisedButton(
                child: Text('Pick Image'),
                onPressed: (){
                  _showPickOptionDialog(context);
                },
              ),
              SizedBox(height: 50,),
              TextFormField(
                style: TextStyle(
                    color: Colors.white
                ),
                controller: _prenomController,
                validator: (val) =>
                val.isNotEmpty ? null : 'Votre prénom',
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                  fillColor: Colors.white,
                  hintText: 'Votre prénom',
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                  prefixIcon: Icon(Icons.drive_file_rename_outline, color: Colors.white,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),

                ),
              ),
              SizedBox(height: 50,),

              TextFormField(
                style: TextStyle(
                    color: Colors.white
                ),
                controller: _nomController,
                validator: (val) =>
                val.isNotEmpty ? null : 'Votre nom',
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                  fillColor: Colors.white,
                  hintText: 'Votre nom',
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                  prefixIcon: Icon(Icons.drive_file_rename_outline, color: Colors.white,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),

                ),
              ),
              SizedBox(height: 50,),

              TextFormField(
                style: TextStyle(
                    color: Colors.white
                ),
                controller: _emailController,
                validator: (val) =>
                val.isNotEmpty ? null : 'Entrer votre adresse e-mail',
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),
                  fillColor: Colors.white,
                  hintText: '${widget.email.trim()}',
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                  prefixIcon: Icon(Icons.mail, color: Colors.white,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.white
                      )
                  ),

                ),
              ),
              SizedBox(height: 50,),
              MaterialButton(
                onPressed: () async{


                },
                height: 60,
                color: Colors.black12,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)                      ),
                child: Text(
                  'Sauvegarder',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),

        ),

      ),
    );
  }

   _loadPicker(ImageSource source) async {
     final imagePicker = ImagePicker();

     var picked = await imagePicker.pickImage(source: source);

     if(picked != null)
       {
         //_cropImage(picked);
         setState(() {
           _pickedImage = File(picked.path);
         });
       }

     Navigator.pop(context);


   }

  void _showPickOptionDialog(BuildContext context) {
    showDialog(context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Pick from galery'),
                onTap: (){

                  _loadPicker(ImageSource.gallery);
                },
              ),
              ListTile(
                title: Text('Take a picture'),
                onTap: (){
                  _loadPicker(ImageSource.camera);

                },
              )
            ],
          ),
        )
    );
  }

  void _cropImage(File picked) async {
    final imageCropped = ImageCropper();

    var cropped = await ImageCropper.cropImage(sourcePath: picked.path,
    aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );

    if(cropped != null){
      setState(() {
        _pickedImage = cropped;
      });
    }
  }
}
