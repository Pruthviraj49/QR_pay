import 'package:flutter/material.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';

class EasyPay extends StatefulWidget {
  const EasyPay({super.key});

  @override
  State<EasyPay> createState() => _EasyPayState();
}

class _EasyPayState extends State<EasyPay> {
  @override
  // final List<ApplicationMeta> appMetaList = await UpiPay.getInstalledUpiApps();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
