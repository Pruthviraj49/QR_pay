import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/auth/login.dart';
import 'package:qr_code/bottomNavigate.dart';
import 'package:qr_code/functions/googlePay.dart';

import 'package:qr_code/functions/upiPayment.dart';
import 'package:qr_code/homeScreen.dart';
import 'package:qr_code/qrGenerate.dart';
import 'package:qr_code/qrScanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: "lato"),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return LoginForm();
            }
          },
        ));
  }
}
