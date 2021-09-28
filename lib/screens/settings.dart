import 'package:flutter/material.dart';
import 'package:herespot/screens/updatePassword.dart';
import 'package:herespot/services/authentication/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {




  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Réglages'),
        backgroundColor: Colors.black,
        leading:   IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);


          }
      ),

      ),
      body: SettingsList(
        sections: [

          SettingsSection(
            title: 'Compte',
            tiles: [
              SettingsTile(title: 'Mot de passe', leading: Icon(Icons.security),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdatePassword(),)
                  );
                },

              ),


              SettingsTile(title: 'se déconnecter', leading: Icon(Icons.exit_to_app)
              , onTap: (){
                loginProvider.logout();
                },),
            ],
          ),

        ],
      ),
    );
  }
}
