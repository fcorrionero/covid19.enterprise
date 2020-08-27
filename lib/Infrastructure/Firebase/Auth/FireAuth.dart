import 'package:firebase_auth/firebase_auth.dart';

class FireAuth
{

  Future<UserCredential> login(String email, String password, String code) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // For debug
      if (e.code == 'user-not-found') {
        if ('123456' == code) {
          this.createUser(email, password);
        }
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      throw e;
    }
  }

  Future<UserCredential> createUser(String email, String password) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      UserCredential userCredentialLogged = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredentialLogged;
    }on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

}