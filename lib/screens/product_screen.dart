import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Productv Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
