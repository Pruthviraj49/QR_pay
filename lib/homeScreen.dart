import 'package:flutter/material.dart';
import 'package:qr_code/ordersView.dart';
import 'package:qr_code/qrGenerate.dart';
import 'package:qr_code/qrScanner.dart';
import 'mainDrawer.dart';

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

  void navigateToOrders(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const OrdersView()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              title: const Text("VJTI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  textDirection: TextDirection.ltr),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3366FF),
                      Color(0xFF00CCFF),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            ),
          ),
          drawer: MainDrawer(),
          body: SingleChildScrollView(
              child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () {
                    navigateToGenerate(context);
                  },
                  child: const Text("Generate QR"),
                ),
                ElevatedButton(
                  onPressed: () {
                    navigateToScan(context);
                  },
                  child: const Text("Scan QR"),
                ),
                ElevatedButton(
                  onPressed: () {
                    navigateToOrders(context);
                  },
                  child: const Text("Orders"),
                ),
              ],
            ),
          ))),
    );
  }
}
