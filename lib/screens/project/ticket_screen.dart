import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Ticket Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
