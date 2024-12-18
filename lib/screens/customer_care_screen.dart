import 'package:flutter/material.dart';

class CustomerCare extends StatelessWidget {
  const CustomerCare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Care Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Customer Care Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
