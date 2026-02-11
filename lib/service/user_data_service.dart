import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataService {
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return null;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        return doc.data();
    } else {
      log("User document not found");
      return null;
    }
    } catch (e) {
      log("Error getting user data: $e");
      return null;
    }
  }
}
