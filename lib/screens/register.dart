import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herespot/database/database.dart';
import 'package:provider/provider.dart';
import 'package:herespot/services/authentication/auth_services.dart';


class Register extends StatefulWidget {

  //Variable de la classe register
  final Function toggleScreen;

  //Constructeur de la classe register
  const Register({Key key, this.toggleScreen}) : super(key: key);

  //Création du state de la page
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //Variable de la classe registerState
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  Database db = new Database();
  String email;
  String uid;

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

  //Widget qui va build la page register
  @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<AuthServices>(context);


    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/background.jpg',
          ),
          fit: BoxFit.cover
        )
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
                    Text(
                      'HereSpot ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Créer un compte pour continuer',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 50,),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.grey
                      ),
                      controller: _emailController,
                      validator: (val) =>
                      val.isNotEmpty ? null : 'Entrer un e-mail',
                      decoration: InputDecoration(
                          hintText: 'Entrez votre adresse e-mail',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ),
                          prefixIcon: Icon(Icons.mail, color: Colors.white,),
                          border:OutlineInputBorder(
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
                        color: Colors.grey
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
                          hintText: 'Entrez votre mot de passe',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0),
                          prefixIcon: Icon(Icons.vpn_key, color: Colors.white,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      color: Colors.white
                      )
                    ),
                      ),
                    ),


                    SizedBox(height: 40,),
                    MaterialButton(
                      onPressed: () async{
                        final FirebaseAuth auth = FirebaseAuth.instance;

                        if(_formkey.currentState.validate())
                        {
                          print('Email: ${_emailController.text}');
                          print('Email: ${_passwordController.text}');



                          await loginProvider.register(
                              _emailController.text.trim(),
                              _passwordController.text.trim()
                          );

                          final User user = auth.currentUser;

                          email =  user.email;
                          uid = user.uid;

                          db.createUserInfo(uid, email);

                        }
                      },
                      height: 60,
                      minWidth: loginProvider.isLoading ? null : double.infinity,
                      color: Colors.black12,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)                      ),
                      child: loginProvider.isLoading ? CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      ) : Text(
                        'S''enregistrer',
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
                        Text('J''ai déjà un compte', style: TextStyle(color: Colors.white),),
                        SizedBox(width: 10,),
                        TextButton(onPressed: () => widget.toggleScreen(),
                            child: Text('Se connecter', style: TextStyle(color: Colors.white),))
                      ],
                    ),
                    SizedBox(height: 20,),
                    if(loginProvider.errorMessage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.amberAccent,
                        child: ListTile(
                          title: Text("Un problème est survenu lors de l'enregistrement"),
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
