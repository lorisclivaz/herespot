import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herespot/screens/Authentication.dart';
import 'package:herespot/screens/homeScreen.dart';
import 'package:herespot/services/loading/loadingpage.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user != null)
      {
        return HomeScreen();
      }else{
      return Authentication();
    }

  }



}

