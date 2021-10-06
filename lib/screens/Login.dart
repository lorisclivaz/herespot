import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herespot/database/database.dart';
import 'package:herespot/screens/updatePassword.dart';
import 'package:provider/provider.dart';
import 'package:herespot/services/authentication/auth_services.dart';

class Login extends StatefulWidget {

  //Variable de la classe Login
  final Function toggleScreen;

  //Constructeur de la classe login
  const Login({Key key, this.toggleScreen}) : super(key: key);

  //Création du state de la page
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //Variable de la classe loginstate
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();




  //Méthode d'initialisation
  @override
  void initState() {

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  //Méthode de suppression
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  //Widget de build de la page login
  @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<AuthServices>(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [

                    SizedBox(height: 20,),

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

                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Column(
                      children: [

                        Text(
                          'HereSpot',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'se connecter pour continuer',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
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
                        hintText: 'Entrez votre adresse e-mail',
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
                    TextFormField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (val) => val.length < 6 ? 'Entrer plus de 6 charactères' : null,
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
                          hintText: 'Entrez votre mot de passe',
                          hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),

                          prefixIcon: Icon(Icons.vpn_key, color: Colors.white,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),


                    SizedBox(height: 40,),
                    MaterialButton(
                        onPressed: () async{



                          if(_formkey.currentState.validate())
                            {


                                await loginProvider.login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim()
                                );
                            }
                        },
                        height: 60,
                      minWidth: loginProvider.isLoading ? null : double.infinity,
                      color: Colors.black12,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)                      ),
                      child: loginProvider.isLoading
                      ? CircularProgressIndicator()
                      : Text(
                        'Se connecter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdatePassword(),)
                          );
                        },
                            child: Text('J''ai oublié mon mot de passe', style: TextStyle(
                              color: Colors.white
                            ),),
                        ),
                        SizedBox(width: 10,),

                        TextButton(onPressed: () => widget.toggleScreen(),
                            child: Text('S''enregistrer',style: TextStyle(
                              color: Colors.white
                            ),))
                      ],
                    ),

                    SizedBox(height: 20,),
                    if(loginProvider.errorMessage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.amberAccent,
                        child: ListTile(
                          title: Text("Aucun utilisateur enregistré à cette adresse, veuillez vous enregistrer !"),
                          leading: Icon(Icons.error),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: (){
                              loginProvider.setMessage(null);
                            },
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
