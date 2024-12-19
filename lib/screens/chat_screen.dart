import 'dart:typed_data';

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

  Uint8List? _savedImageBytes;

  Future<void> _saveEditedImage() async {
    try {
      // Export the drawn image as a byte array
      Uint8List? byteArray = await _controller.exportImage();

      if (byteArray != null) {
        setState(() {
          _savedImageBytes = byteArray;
        });

        // Notify the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image saved in memory!")),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save image: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Painter Example"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: _saveEditedImage,
          ),
        ],
      ),
      body: Column(
        children: [
          // Image painter for editing
          Expanded(
            flex: 2,
            child: ImagePainter.asset(
              "assets/images/layout_floor_3_ticket.png",
              controller: _controller,
              scalable: true,
              textDelegate: TextDelegate(),
            ),
          ),
          // Display the saved image
          Expanded(
            flex: 1,
            child: _savedImageBytes == null
                ? const Center(
                    child: Text(
                      "No saved image yet",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : Column(
                    children: [
                      const Text(
                        "Saved Image:",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Expanded(
                        child: Image.memory(
                          _savedImageBytes!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
