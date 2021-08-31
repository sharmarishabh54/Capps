import 'package:capps/models/thinker_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _store;

  AuthService(this._auth, this._store);

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential user = await _auth.signInWithCredential(credential);
      print(user.user.displayName);
      addUser(user);
      return user.user;
    } catch (error) {
      print(error);
      return error;
    }
  }

  Future<void> addUser(UserCredential user) async {
    DocumentReference ref = _store.collection('users').doc(user.user.uid);
    DocumentSnapshot y = await ref.get();
    if (!y.exists) {
      return ref.set(
        {
          'uid': user.user.uid,
          'email': user.user.email,
          'name': user.user.displayName,
          'rated': [],
          'status': 'none',
          'age': 0,
        },
      );
    }
  }

  Future<void> updateUser(
      UserCredential user, FirebaseFirestore _db, Thinker thinker) async {
    DocumentReference ref = _db.collection('users').doc(user.user.uid);
    DocumentSnapshot y = await ref.get();
    if (y.exists) {
      return ref.set(thinker.toJson());
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
