import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class OrderModel {
  String itemId;
  String itemName;
  int quantity;
  int total;
  Timestamp timestamp;

  OrderModel({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.total,
    required this.timestamp,
  });
}

class _OrdersViewState extends State<OrdersView> {
  User? user;

  @override
  List<OrderModel> _orders = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchData();
  }

  void fetchData() async {
    String _uid = user!.uid;

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(Duration(milliseconds: 50));
      final orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(_uid)
          .collection('list')
          .get();

      List<OrderModel> orders = [];
      orderSnapshot.docs.forEach((orderDoc) {
        final data = orderDoc.data();
        OrderModel order = OrderModel(
          itemId: orderDoc.id,
          itemName: data['itemName'] ?? '',
          quantity: data['quantity'] ?? 0,
          total: data['total'] ?? 0,
          timestamp: data['timestamp'] ?? Timestamp.now(),
        );
        orders.add(order);
      });

      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching order data: $error');
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDateTime = DateFormat('dd/MM  HH:mm').format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16.0),
                  ListView.builder(
                    itemCount: _orders.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      OrderModel order = _orders[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                              title: Text(
                                '${order.itemName}',
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                  'Quantity: ${order.quantity.toString()}'),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total :  ₹${order.total}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text('${formatTimestamp(order.timestamp)}'),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
