import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ImagePainterController _controller = ImagePainterController(
    color: const Color.fromARGB(255, 255, 0, 0),
    strokeWidth: 2,
    mode: PaintMode.rect,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Painter Example"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: (){},
          )
        ],
      ),
      body: ImagePainter.asset(
        "assets/images/layout_floor_3_ticket.png",
        controller: _controller,
        scalable: true,
        textDelegate: TextDelegate(),
      ),
    );
  }


}