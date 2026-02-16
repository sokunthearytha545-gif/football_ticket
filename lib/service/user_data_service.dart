import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataService {
  Stream<Map<String, dynamic>?> getUserDataStream() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Stream.value(null);
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((doc) => doc.data());
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'name': name, 'phone': phone},
      );
    } catch (e) {
      log("Error updating user data: $e");
    }
  }

  Future<void> updateUserProfile({required String profile}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'profile': profile},
      );
    } catch (e) {
      log("Error updating user profile: $e");
    }
  }
}
