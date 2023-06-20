import 'package:flutter/material.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Place the QR Code in the area",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                )),
                Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.white,
                    )),
                Expanded(
                    child: Container(
                  color: Colors.black,
                )),
              ],
            )),
      ),
    );
  }
}
