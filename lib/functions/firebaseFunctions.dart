import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static saveUser(String name, email, String branch, uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'name': name,
      'branch': branch,
      'userId': uid,
    });
  }
}
