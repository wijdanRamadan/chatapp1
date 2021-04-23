
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {

  FirebaseAuth firebaseAuth;
  UserRepository()
  {
    this.firebaseAuth = FirebaseAuth.instance;
  }

 Future<User> createUser(String email , String password) async
 {
   try {
     var result = await
     firebaseAuth.createUserWithEmailAndPassword(
         email: email,
         password: password);
     return result.user;
   }

   catch(e){
     throw Exception(e.toString());
   }
 }

 Future<User> signInUser(String email , String password) async {
    var result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
 }
 Future<void> signOut() async
 {
   await firebaseAuth.signOut();
 }

 Future<bool> isSignedIn() async{
    var currentUser = await firebaseAuth.currentUser;
    return currentUser != null ;
 }
 Future<User> getCurrentUser() async {
    return await firebaseAuth.currentUser;
 }
}