import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatefulWidget {
  const GooglePay({super.key});

  @override
  State<GooglePay> createState() => _GooglePayState();
}

const _paymentItems = [
  PaymentItem(amount: '100', label: 'Total', status: PaymentItemStatus.pending)
];

class _GooglePayState extends State<GooglePay> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            title: const Text(
              "Order Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
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
        body: Column(
          children: [
            Text("Hello World"),
            GooglePayButton(
                paymentConfigurationAsset: 'google_pay.json',
                onPaymentResult: print,
                paymentItems: _paymentItems)
          ],
        ),
      ),
    );
  }
}
