import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:herespot/services/authentication/auth_services.dart';

class Login extends StatefulWidget {

  final Function toggleScreen;


  const Login({Key key, this.toggleScreen}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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

                  Column(
                    children: [

                      Text(
                        'HereSpot',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: _emailController,
                    validator: (val) =>
                      val.isNotEmpty ? null : 'Please enter a email address',
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
                    validator: (val) => val.length < 6 ? 'Enter more than 6 char' : null,
                    decoration: InputDecoration(
                        hintText: 'Password',
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


                            await loginProvider.login(
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
                    child: loginProvider.isLoading
                    ? CircularProgressIndicator()
                    : Text(
                      'Login',
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
                      Text('Don''t have an account'),
                      SizedBox(width: 10,),
                      TextButton(onPressed: () => widget.toggleScreen(),
                          child: Text('Register'))
                    ],
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
