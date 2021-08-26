import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationClass{
  final FirebaseAuth _firebaseAuth;
  AuthenticationClass(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();
  Future<String> signIn({required String email,required String password}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print('Sign in done');
      return 'Done';
    } on FirebaseAuthException catch (e){
      return e.message.toString();

    }

  }


  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
  Future<String> signUp({required String email,required String password,required String username,required String phone}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value){
        FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).set(
            {
              'Username':username,
              'Phone':phone
            });

      });
      

      return 'Done';
    }on FirebaseAuthException catch(e){
      return e.message.toString();

    }

  }

}