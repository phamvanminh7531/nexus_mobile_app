import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Chat Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
