import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:herespot/services/authentication/auth_services.dart';


class Register extends StatefulWidget {

  final Function toggleScreen;

  const Register({Key key, this.toggleScreen}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<AuthServices>(context);


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,),
                      onPressed: (){}
                  ),
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
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'HereSpot ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Créer un compte pour continuer',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: _emailController,
                    validator: (val) =>
                    val.isNotEmpty ? null : 'Entrer un e-mail',
                    decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (val) => val.length < 6 ? 'Entrer plus de 6 charactères' : null,
                    decoration: InputDecoration(
                        hintText: 'Mot de passe',
                        prefixIcon: Icon(Icons.vpn_key),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),


                  SizedBox(height: 10,),
                  MaterialButton(
                    onPressed: () async{
                      if(_formkey.currentState.validate())
                      {
                        print('Email: ${_emailController.text}');
                        print('Email: ${_passwordController.text}');

                        await loginProvider.register(
                            _emailController.text.trim(),
                            _passwordController.text.trim()
                        );
                      }
                    },
                    height: 60,
                    minWidth: loginProvider.isLoading ? null : double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                      Text('J''ai déjà un compte'),
                      SizedBox(width: 10,),
                      TextButton(onPressed: () => widget.toggleScreen(),
                          child: Text('Se connecter'))
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(loginProvider.errorMessage != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Text(loginProvider.errorMessage),
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
    );
  }
}
