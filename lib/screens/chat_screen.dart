import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> _saveEditedImage() async {
    try {
      // Export the drawn image
      Uint8List? byteArray = await _controller.exportImage();

      if (byteArray != null) {
        // Get the app's documents directory
        final directory = await getApplicationDocumentsDirectory();
        final filePath = "${directory.path}/layout_floor_3_ticket.png";

        // Save the file
        final file = File(filePath);
        await file.writeAsBytes(byteArray);

        // Notify the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image saved to: $filePath")),
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
      body: ImagePainter.asset(
        "assets/images/layout_floor_3_ticket.png",
        controller: _controller,
        scalable: true,
        textDelegate: TextDelegate(),
      ),
    );
  }
}
