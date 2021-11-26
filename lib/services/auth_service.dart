import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  MyUser? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    print(user.email);
    return MyUser(user.uid, user.email);
  }

  Stream<MyUser?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<MyUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  Future<MyUser?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    print("Signing Out");
    return await _firebaseAuth.signOut();
  }
}
