import 'package:flutter/material.dart';
import 'package:herespot/screens/Login.dart';
import 'package:herespot/screens/register.dart';


class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool isToggle = false;

  void toggleScreen(){
    setState(() {
      isToggle = !isToggle;
    });
  }

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
