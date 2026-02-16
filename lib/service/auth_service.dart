import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<User?> signUp({
  required String name,
  required String email,
  required String phone,
  required String password,
  String picture='',
}) async {
  try {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = result.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'picture': picture,
        'created_at': FieldValue.serverTimestamp(),
      });
    }
    return user;
  } on FirebaseAuthException catch (e) {
    log('Sign up error: ${e.message}');
    throw e.message ?? 'Sign up failed';
  } catch (e, stack) {
    log('Sign up error: $e');
    log('Stack: $stack');
    rethrow;
  }

}

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Login failed';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
