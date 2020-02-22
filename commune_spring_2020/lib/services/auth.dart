import 'package:firebase_auth/firebase_auth.dart';
import 'package:commune_spring_2020/Models/Users.dart';


class AuthServices{

  final FirebaseAuth _auth=   FirebaseAuth.instance;
  
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }
  //register with username and password
  Future signUp(String email, String password)async{
    try{
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email,password: password );
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with u and p
  Future signIn(String email, String password)async{
      try{
        AuthResult result= await _auth.signInWithEmailAndPassword(email: email,password: password );
        FirebaseUser user=result.user;
        assert(user !=null);
        assert(await user.getIdToken()!=null);
        final FirebaseUser currentUser=await _auth.currentUser();
        assert(user.uid==currentUser.uid);
         
        return user;
      }catch(e){
        print(e.toString());
         print(email+"/////////////");
        return null;
      }
    }
  //sign out
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
