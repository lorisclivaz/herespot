import 'package:flutter/material.dart';
import 'package:herespot/screens/Login.dart';
import 'package:herespot/screens/register.dart';


class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  //variable permettant de savoir si le user et connecté ou pas
  bool isToggle = false;

  //Methode permettant de set le state du user
  void toggleScreen(){
    setState(() {
      isToggle = !isToggle;
    });
  }

  //Widget permettant de build la page register ou la page login selon le "istoggle"
  @override
  Widget build(BuildContext context) {

    if(isToggle)
      {
        return Register(toggleScreen: toggleScreen);
      }else{
      return Login(toggleScreen: toggleScreen);
    }


  }
}
