import 'package:firebase_auth/firebase_auth.dart';

class UserCredidentials{

  final FirebaseAuth auth = FirebaseAuth.instance;
  String email;


   void inputData() async{
    final User user = auth.currentUser;

    email = await user.email;

    print("User email : "+ email);
  }


}