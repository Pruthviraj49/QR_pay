import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebaseFunctions.dart';

class AuthServices {
  static signupUser(String email, String password, String name,
      String branchName, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      // await FirebaseAuth.instance.currentUser!.uid;
      await FirestoreServices.saveUser(
          name, email, branchName, userCredential.user!.uid);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged in')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static logoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Logged out successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred while logging out')));
    }
  }
}
