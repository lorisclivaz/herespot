import 'package:herespot/services/authentication/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context) ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page '),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => loginProvider.logout(),
          )
        ],
      ),
    );
  }
}
