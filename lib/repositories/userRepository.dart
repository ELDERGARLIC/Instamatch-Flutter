import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;


  UserRepository({
    FirebaseAuth firebaseAuth,
    FirebaseFirestore firestore,
  }): _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _firestore = firestore ?? FirebaseFirestore.instance;


  Future<void> signInWithEmail(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> isFirstTime(String userId) async{
    bool exist;
    await FirebaseFirestore.instance.collection('users').doc(userId).get().then((user){
      exist = user.exists;
    });
    return exist;
  }

  Future<void> signUpWithEmail(String email, String password) async {
    print(_firebaseAuth);
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  //TODO: might have problem!-1 /// final currentUser = _firebaseAuth.currentUser();
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser !=null;
  }

  //TODO: might have problem!-2 /// await _firebaseAuth.currentUser()).uid
  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser.uid);
  }

}