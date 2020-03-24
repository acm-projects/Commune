import 'package:commune_spring_2020/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:commune_spring_2020/Models/User.dart';

class AuthService{
  
  final FirebaseAuth _auth=FirebaseAuth.instance;

  //make the firebase user into a user object
  User _userFromFireBase(FirebaseUser user){
    if(user!=null){
      return User(uid: user.uid);
    }
    return null;
  }

  //auth change user stream 
  Stream<User> get user{
      return _auth.onAuthStateChanged.map((FirebaseUser user)=>_userFromFireBase(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signIn(String email, String password) async{
    try{
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future signUp(String email,String password, int budget, String displayName) async{
    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password) ;
      FirebaseUser user= result.user;

      //create a new doc for the user
      await DatabaseService(uid:user.uid).updateUserData(email, budget, displayName,user.uid);

      return _userFromFireBase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }  
  // sign out
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.message);
      return null;
    }
  }
}