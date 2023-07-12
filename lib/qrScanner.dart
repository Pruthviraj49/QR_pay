import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code/homeScreen.dart';
import 'package:qr_code/transactionInfo.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  String? globalResult;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(bottom: 10, child: buildResult()),
          Positioned(top: 10, child: builControlButtons()),
        ],
      )),
    );
  }

  Widget buildQrView(BuildContext context) {
    return (QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderLength: 20,
        borderRadius: 10,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    ));
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
        globalResult = barcode.code;
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => TransactionInfo(globalResult)))
            .then((_) {
          // This code will execute after returning from the TransactionInfo screen
          controller.resumeCamera(); // Resume the camera scanning
        });
      });
      controller.pauseCamera(); // Pause the camera after receiving a barcode
    });
  }

  Widget buildResult() => const Text(
        // barcode != null ? 'Result : ${barcode!.code}' :
        'Scan QR Code',
        maxLines: 3,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      );

  Widget builControlButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            color: Colors.white,
            icon: FutureBuilder(
              future: controller?.getFlashStatus(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return Icon(
                    snapshot.data! ? Icons.flash_on : Icons.flash_off,
                    size: 35,
                  );
                } else {
                  return Container();
                }
              },
            ),
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          IconButton(
            color: Colors.white,
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
            icon: FutureBuilder(
              future: controller?.getCameraInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return const Icon(
                    Icons.switch_camera_outlined,
                    size: 35,
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      );
}
