import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';


class AuthServices with ChangeNotifier{

  //Variable de la classe authServices
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String email;

  //Méthode permettant l'enregistrement d'un utilisateur
  Future register(String email, String password) async {
    setLoading(true);
    try{
      UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setLoading(false);
      setMessage('No internet, please connect to internet');
    }
    catch(e){
      setLoading(false);
      print(e);
      setMessage(e.message);

    }
    notifyListeners();
  }


  //Méthode permettant le login d'un utilisateur
  Future login(String email, String password) async {
    try{
      setLoading(true);

      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      User user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setLoading(false);
      setMessage('No internet, please connect to internet');
    }
    catch(e){
      setLoading(false);
      print(e);
      setMessage(e.message);
    }
    notifyListeners();

  }

  //Méthode permettant le logout
  Future logout() async {
    await firebaseAuth.signOut();
  }

  //Méthode qui change l'état du login
  void setLoading(val)
  {
    _isLoading = val;
    notifyListeners();
  }

  //Méthode qui change l'état du message d'erreur
  void setMessage(message)
  {
    _errorMessage = message;
    notifyListeners();
  }

  //Méthode qui va streaming le user tout au long de son expérience sur l'application
  Stream<User> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}