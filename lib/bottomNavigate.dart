import 'package:flutter/material.dart';
import 'package:qr_code/homeScreen.dart';
import 'package:qr_code/ordersView.dart';
import 'package:qr_code/qrScanner.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  List<Widget> _widgetOptions = [
    HomeScreen(),
    QRScanner(),
    OrdersView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        elevation: 2,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
