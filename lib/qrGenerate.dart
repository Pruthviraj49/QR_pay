import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  final itemName = TextEditingController();
  String? data;
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
        body: Padding(
          padding:
              const EdgeInsets.only(top: 100, bottom: 20, left: 20, right: 20),
          child: Column(children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter item name',
              ),
              controller: itemName,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  data = itemName.text;
                });
              },
              child: const Text("Generate QR"),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: QrImageView(
                data: '$data',
                version: QrVersions.auto,
                size: 200.0,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
