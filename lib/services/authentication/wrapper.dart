import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herespot/screens/Authentication.dart';
import 'package:herespot/screens/Login.dart';
import 'package:herespot/screens/homeScreen2.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user != null)
      {
        return HomeScreen2();
      }else{
      return Authentication();
    }

  }
}
