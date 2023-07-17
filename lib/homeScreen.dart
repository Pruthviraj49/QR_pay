import 'package:flutter/material.dart';
import 'package:qr_code/ordersView.dart';
import 'package:qr_code/qrGenerate.dart';
import 'package:qr_code/qrScanner.dart';
import 'profilePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToGenerate(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => QRGenerator()));
  }

  void navigateToScan(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const QRScanner()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Profile(),
      ),
    );
  }
}
