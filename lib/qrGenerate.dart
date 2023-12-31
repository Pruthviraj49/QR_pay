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
            title: const Text("Generate QR",
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
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0, right: 15, left: 15),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter item name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                controller: itemName,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: QrImageView(
                data: '$data.trim()',
                version: QrVersions.auto,
                size: 250.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // Text color
                padding: EdgeInsets.symmetric(
                    horizontal: 36, vertical: 16), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30), // Button border radius
                ),
                elevation: 3, // Button shadow
              ),
              onPressed: () {
                setState(() {
                  data = itemName.text;
                });
              },
              child: Text(
                "Generate QR",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
