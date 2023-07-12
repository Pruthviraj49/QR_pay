import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  void initState() {
    super.initState();
    fetchTransactionData();
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
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching order data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
          child: Column(
        children: [
          Text('Hello Data : ${widget.itemID}'),
          Text(items?.itemName ?? "NA"),
          Text(items?.amount.toString() ?? "NA"),
          Text(items?.receiverName ?? "NA"),
          Text(items?.recieverUPI ?? "NA"),
        ],
      )),
    );
  }
}
