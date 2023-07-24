import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/functions/upiPayment.dart';
import 'package:qr_code/ordersView.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class TransactionInfo extends StatefulWidget {
  String? itemID;
  TransactionInfo(this.itemID, {super.key});

  @override
  State<TransactionInfo> createState() => _TransactionInfoState();
}

class ItemModel {
  String itemName;
  int amount;
  String receiverName;
  String recieverUPI;

  ItemModel({
    required this.itemName,
    required this.amount,
    required this.receiverName,
    required this.recieverUPI,
  });
}

class _TransactionInfoState extends State<TransactionInfo> {
  bool _isLoading = false;
  ItemModel? items;
  double? total;

  void initState() {
    super.initState();
    fetchTransactionData();
    // _razorpay = Razorpay();
    // _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void fetchTransactionData() async {
    ItemModel? item;
    String? _id = widget.itemID;

    setState(() {
      _isLoading = true;
    });
    try {
      final itemSnapshot = await FirebaseFirestore.instance
          .collection('itemStored')
          .doc(_id)
          .get();
      if (itemSnapshot.exists) {
        final itemData = itemSnapshot.data();
        item = ItemModel(
            itemName: itemData!['itemName'],
            amount: itemData['amount'],
            receiverName: itemData['recieverName'],
            recieverUPI: itemData['recieverUPI']);
      }

      setState(() {
        items = item;
        total = items?.amount.toDouble();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching order data: $e');
    }
  }

  int quantity = 1;

  void increment(double price) {
    setState(() {
      quantity++;
      total = price * quantity;
    });
  }

  void decrement(double price) {
    setState(() {
      if (quantity > 1) {
        quantity--;
        total = price * quantity;
      }
    });
  }

  Razorpay? _razorpay;

  @override
  void dispose() {
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print("Payment success - Payment ID: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print(
        "Payment error - Code: ${response.code}, Message: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External wallet - Wallet Name: ${response.walletName}");
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_4WemY756lrIb0j', // Replace with your Razorpay API key
      'amount': 100, // Amount in paisa
      'name': 'Vjti Canteen',
      'description': 'Payment for Canteen',
      'prefill': {
        'contact': '9529142977',
        'email': 'abcd@gmail.com',
      },
      'external': {
        'wallets': ['paytm'], // Optional: List of supported external wallets
      }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text("Payment Details",
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
      body: SizedBox(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 40),
              child: Text(
                'Item\'s added',
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 30, top: 25, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items?.itemName ?? "NA",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text("₹${items?.amount.toString() ?? 'NA'}")
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                decrement(items?.amount.toDouble() ?? 0);
                              },
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                increment(items?.amount.toDouble() ?? 0);
                              },
                            ),
                          ],
                        ),
                        Text("₹${total}")
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Reciever Name :  ${items?.receiverName ?? "NA"}",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Reciever UPI :  ${items?.recieverUPI ?? "NA"}",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Total :   ₹ ${total}",
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // Text color
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 36,
                                        vertical: 16), // Button padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // Button border radius
                                    ),
                                    elevation: 3, // Button shadow
                                  ),
                                  onPressed: () {
                                    // openCheckout();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpiPaymentScreen()));
                                  },
                                  child: Text(
                                    "Make Payment",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
